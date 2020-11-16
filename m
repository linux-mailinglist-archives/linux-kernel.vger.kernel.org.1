Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF2C2B3B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKPCpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 21:45:46 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51429 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgKPCpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 21:45:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFRs7GC_1605494743;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFRs7GC_1605494743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Nov 2020 10:45:43 +0800
Subject: Re: [PATCH 1/6] time: fix kernel-doc markup
To:     Thomas Gleixner <tglx@linutronix.de>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
 <87wnym44ol.fsf@nanos.tec.linutronix.de>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d36cf95b-4073-8c3d-e6b6-1ae583faca31@linux.alibaba.com>
Date:   Mon, 16 Nov 2020 10:44:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87wnym44ol.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/16 ÉÏÎç6:48, Thomas Gleixner Ð´µÀ:
> On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:
> 
>> The kernel-doc interface error cause some warning:
> 
> I fixes the lot up and applied it. Please look at the changes I did and
> be more careful next time.
> 

Hi Thomas,

Thanks a lot for all fix and kindly coaching! I have learned a lot here.

Thanks
Alex
