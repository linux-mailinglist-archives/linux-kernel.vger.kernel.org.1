Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211DB28DAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgJNISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:18:50 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:55316 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:18:49 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8716B2153C07
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
To:     Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
 <3897a8ce5760affa304952c2d30c1266589407f2.camel@perches.com>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform
Message-ID: <e6fd4ba1-b431-afd8-1800-3a8f4b74f30e@omprussia.ru>
Date:   Wed, 14 Oct 2020 11:18:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <3897a8ce5760affa304952c2d30c1266589407f2.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.132.63]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.10.2020 1:44, Joe Perches wrote:

>> Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>> I'm doing some little refactoring in module_sig_check()...
>>
>> [1/2] module: merge repetitive strings in module_sig_check()
>> [2/2] module: unindent comments in module_sig_check()
> 
> I think this code is rather cryptic and could be made clearer.
> 
> How about:
> ---
>   kernel/module.c | 51 ++++++++++++++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 25 deletions(-)

    Looks good. Do you want to post complete patch(es)? :-)

[...]

MBR, Sergei
