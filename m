Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23228E77D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJNTon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:44:43 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:44640 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:44:43 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 32665206E42A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
To:     Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
 <3897a8ce5760affa304952c2d30c1266589407f2.camel@perches.com>
 <e6fd4ba1-b431-afd8-1800-3a8f4b74f30e@omprussia.ru>
 <e8382da95dda4dffa06f81a05e92e5555a074bab.camel@perches.com>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <d97f1700-f149-0fb5-99cf-3af421e399dc@omprussia.ru>
Date:   Wed, 14 Oct 2020 22:44:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e8382da95dda4dffa06f81a05e92e5555a074bab.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.151.133]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 11:35 AM, Joe Perches wrote:

[...]
>>>> Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>>>> I'm doing some little refactoring in module_sig_check()...
>>>>
>>>> [1/2] module: merge repetitive strings in module_sig_check()
>>>> [2/2] module: unindent comments in module_sig_check()
>>>
>>> I think this code is rather cryptic and could be made clearer.
>>>
>>> How about:
>>> ---
>>>   kernel/module.c | 51 ++++++++++++++++++++++++++-------------------------
>>>   1 file changed, 26 insertions(+), 25 deletions(-)
>>
>>     Looks good. Do you want to post complete patch(es)? :-)
> 
> I don't like posting actual patches on top of other people.
> It's a complete and compilable diff, it's just unsigned.

   It does too many things simultaneously, I'll need to decompose it...

> If you want a Signed-off-by: here's one:
> 
> Signed-off-by: Joe Perches <joe@perches.com>

   I think I'll rather use Suggested-by: where appropriate...

MBR, Sergei
