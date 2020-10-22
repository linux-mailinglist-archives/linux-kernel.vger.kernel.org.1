Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE092961AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504399AbgJVP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:29:07 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:53132 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438961AbgJVP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:29:06 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru E57F0206FFE5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
To:     Jessica Yu <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
 <20201022150916.GB8608@linux-8ccs>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <ca670986-77d1-98b8-c0ed-d270fc111774@omprussia.ru>
Date:   Thu, 22 Oct 2020 18:29:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022150916.GB8608@linux-8ccs>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.145.115]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/22/20 6:09 PM, Jessica Yu wrote:

>> Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>> I'm doing some little refactoring in module_sig_check()...
>>
>> [1/2] module: merge repetitive strings in module_sig_check()
>> [2/2] module: unindent comments in module_sig_check()
> 
> Hi Sergey,
> 
> I'm fine with these patches, but are you still planning on sending a
> v2 based on Joe Perches' suggestions?

   Yes, I'm going to address his feedback, as soon as I have a time.

> Thanks!
> 
> Jessica

MBR, Sergei
