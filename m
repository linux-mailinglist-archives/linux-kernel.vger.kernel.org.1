Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459912DC2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgLPPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:21:37 -0500
Received: from relay.sw.ru ([185.231.240.75]:38542 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgLPPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:21:37 -0500
Received: from [192.168.15.178]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kpYbK-00DHdZ-4I; Wed, 16 Dec 2020 18:20:26 +0300
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
To:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
 <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
 <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
 <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
 <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
 <c3132ac7e0536a30aefc833df16f5a24de7e4529.camel@gmx.de>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <61ae6135-dca7-db73-f048-0a35f69cb5c4@virtuozzo.com>
Date:   Wed, 16 Dec 2020 18:20:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <c3132ac7e0536a30aefc833df16f5a24de7e4529.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.2020 17:49, Mike Galbraith wrote:
> On Wed, 2020-12-16 at 15:31 +0100, Mike Galbraith wrote:
>> On Wed, 2020-12-16 at 17:23 +0300, Kirill Tkhai wrote:
>>>
>>> Does this regression only cause that one error message "check_release: Can't get the kernel version"
>>> is printed instead of another: "The kernel version is not supported."?
>>
>> The thing does indeed mutter about the kernel version, with or without
>> 9a56493f6942 reverted, but it work despite the muttering with
>> 9a56493f6942 reverted.
> 
> makedumpfile 1.6.7 source only claims to work up to linux-5.4.8, but
> actually does work all the way up until 9a56493f6942.
> 
> If the answer here is that v1,6,7 has reached EOL, that's fine, I'll
> just carry a revert until I can cobble together an updated package.

I think, since there is no a makedumpfile version working, this is a regression,
and it should be workarounded it in kernel.

We may consider a patch like the below till updated makedumpfile is not published:

diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 2b1737c9b244..d6bcad448f52 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -8,6 +8,7 @@
 #include <linux/ns_common.h>
 #include <linux/err.h>
 #include <uapi/linux/utsname.h>
+#include <linux/kref.h>
 
 enum uts_proc {
 	UTS_PROC_OSTYPE,
@@ -21,6 +22,7 @@ struct user_namespace;
 extern struct user_namespace init_user_ns;
 
 struct uts_namespace {
+	struct kref unused;
 	struct new_utsname name;
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
