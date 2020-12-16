Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97B2DC05F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLPMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:36:39 -0500
Received: from relay.sw.ru ([185.231.240.75]:47282 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbgLPMgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:36:38 -0500
Received: from [192.168.15.178]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kpW1e-00DGXy-0H; Wed, 16 Dec 2020 15:35:26 +0300
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
To:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
Date:   Wed, 16 Dec 2020 15:35:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexander,

On 16.12.2020 14:02, Mike Galbraith wrote:
> Greetings,
> 
> With this commit, bisected and confirmed, kdump stops working here,
> makedumpfile saying "check_release: Can't get the kernel version".

hasn't your commit 55d9e11398a4 "kdump: append uts_namespace.name offset to VMCOREINFO"
fixed this issue?

What problem with offset we meet here in case of uts_namespace is even marked with __randomize_layout?

Kirill



