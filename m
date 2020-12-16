Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969A02DC15D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLPNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:34:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:56031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgLPNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608125539;
        bh=ycJYnzzTu5CSFebiiKFEyqbpalwfeB7EYu9Cfd/0d6U=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=ePdwKwiNaxMju5HhkoDg8ABn0bIqVjdhobe5IE6iddU3mg4CrEGMmDwlHA5t07U8E
         xdDHOKiwTo1dAMGH3cliA+uk2S1Rt9H/upVTa2FQN9ONKPuGm24Mn8Lz1QRoVzDLlM
         wDLc2XZqcmWcLWS7HpvB5We6xcZ9Laa0gmX4lJKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1jupjG1rSz-00vhT3; Wed, 16
 Dec 2020 14:32:19 +0100
Message-ID: <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
From:   Mike Galbraith <efault@gmx.de>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Date:   Wed, 16 Dec 2020 14:32:18 +0100
In-Reply-To: <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
         <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NZ3/C4M69miBtyw5geeSlG8wZMFdU5wCwySvM508q3N9//Vh1tp
 f+itRv2cIU4K4vMuLGEm6CNxKaXzHt+iU84Tthhfi1wUC7nlnGM2dL2gkWlrS+wW9UoDcpQ
 BDy8eHV4LVC7bcDXilfZTDzfnokFvKcufvag9c6y55NYE20od/NnAFBFRZ3ovZw3GMbl7RI
 2gKjywL2SPm6AsAvbCp8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zeFgRJ3Bilk=:oB27j47jFLrw7tD+OokBSb
 w812tHpi6C8GpuFJyA1tYx5ALnt9OYcbiFtUiC2jhzyd2iKNwWLBCICs/BkbEfDPJ0kKeCUYF
 8wsD7AyHDT/+jzRtcTonM6zkDtD+SSGxlG9TtBtfYS6a+rSsNWmiJ5wpXZvWiN8SqGk7Ihr0w
 yFhERFyBZCVKFmpegRNf3cdaBvs2zqVllr0KcTV0ZmJ9XHWePIa4g7Y/kAJedxEeELVwpxteU
 cOdvXFRg8Ba5LwVyXdL2coSqVw3pN+6g1kLcj6+r4Di7P1eEQ/E9JBsqvoGXYfw6kbE8+lm4g
 J0jUKvDy3g8bOU4EYLc4RyieMttKhOQCMC8ysYkF9qaeKS8CLZPLL+sDyyrhpI/J913zsXqZN
 +oUJds6ePYTapk9eqjktqL9MyZfSvJV1H7gP77KKo1chjg5NcgUtg7P+I7Kb1fjr86w/BzZhW
 jYH9OsYVR/dxFdNKi+/zE8APP7Cc2TXfNHgpK4YvOiWDz52gWkZpLROFqZunfzvSYOuIxCES5
 rG6hmXF8mD9iYqhWt/DWpjd/0Ji2mZiRSesakXOlDWGlOjQCA0GBOaJiMGQXi5yiLCFaBKkWF
 OmN+TzZ0dVQX7v2+15eNZ8FACj9uhktVKPGJOMMMwtyemR+MSbNgfoA7Lgpa/GDjpGWvVarXx
 zAfYkgkib/8CXyYYpVFP0ngwzhvqAs+ow/qunK3PuShxzpBT6ARmyeqE7aYyQlfZEFRJRPzun
 AgaPeCyfQaLRKRqx5SL/ctNlGoTpBU1+0uLSoS30/ImaRrpNKRDX1lQ8KJO7qCFA+nddgU6J7
 RLlAAlxSmPNiGPPtCs0R2uoH7JtgY3+YJEBDZfo6n2rOOE9OSnY1QOBhYw9n+A5/RADlSbZ7P
 mAQOOSJwUDLM4Iaeg2Ww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-16 at 15:35 +0300, Kirill Tkhai wrote:
> Hi, Alexander,
>
> On 16.12.2020 14:02, Mike Galbraith wrote:
> > Greetings,
> >
> > With this commit, bisected and confirmed, kdump stops working here,
> > makedumpfile saying "check_release: Can't get the kernel version".
>
> hasn't your commit 55d9e11398a4 "kdump: append uts_namespace.name offset=
 to VMCOREINFO"
> fixed this issue?

FWIW, I applied the below, but it didn't help.

=2D--
 kernel/crash_core.c |    1 +
 1 file changed, 1 insertion(+)

=2D-- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);

 	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
 	VMCOREINFO_SYMBOL(node_online_map);
 #ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);

