Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86226627B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIKPsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:48:39 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:41459 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgIKPnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:40 -0400
Subject: Re: gcc crashes with general protection faults in
 5.9.0-rc3-00091-ge28f0104343d
From:   Meelis Roos <mroos@linux.ee>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
 <70778c21-8039-5011-e885-221c2cb06220@linux.ee>
Message-ID: <95c6539f-1c32-5caa-ce0f-e4a5e9859c56@linux.ee>
Date:   Fri, 11 Sep 2020 16:44:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <70778c21-8039-5011-e885-221c2cb06220@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself:
>> This is 5.9.0-rc3-00091-ge28f0104343d on Lenovo t460s that has ran fine up to 5.8.0.
> 
> Now I reproduced the same problem with 5.9.0-rc3 on a HP desktop with Core2Quad CPU. The call trace is very similar and it's crashing gcc again while compiling 5.9-rc4.
> 
> But it seems 5.9-rc4 cures it here as well - whatever the reason might have been.
Nope, the reason was nondeterminism - it happened on the Core2Quad running 5.9-rc4 while trying to compile todays Linux from git.

-- 
Meelis Roos <mroos@linux.ee>
