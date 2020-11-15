Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6882B31D6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 02:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKOB7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 20:59:12 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58259 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgKOB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 20:59:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UFLhAB4_1605405547;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFLhAB4_1605405547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Nov 2020 09:59:08 +0800
Subject: Re: [PATCH v2] Documentation: Chinese translation of
 Documentation/arm64/perf.rst
To:     Jonathan Corbet <corbet@lwn.net>, Bailu Lin <bailu.lin@vivo.com>
Cc:     catalin.marinas@arm.com, harryxiyou@gmail.com, kernel@vivo.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org
References: <07c84db5-9a07-c106-300c-583f2625f9a7@linux.alibaba.com>
 <20201030040541.8733-1-bailu.lin@vivo.com> <20201113152237.41d452a6@lwn.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4d46f9ce-acac-efb7-e417-40d8de0deeeb@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 09:58:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113152237.41d452a6@lwn.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/14 ÉÏÎç6:22, Jonathan Corbet Ð´µÀ:
> On Thu, 29 Oct 2020 21:05:41 -0700
> Bailu Lin <bailu.lin@vivo.com> wrote:
> 
>> This is a Chinese translated version of
>>  Documentation/arm64/perf.rst
>>
>> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
>> ---
>> Changes in v2:
>>  - Modify a translation of 'guest/host/blackout window' as Alex sugguested.
>> ---
>>  Documentation/arm64/perf.rst                  |  2 +
>>  .../translations/zh_CN/arm64/index.rst        |  1 +
>>  .../translations/zh_CN/arm64/perf.rst         | 86 +++++++++++++++++++
>>  3 files changed, 89 insertions(+)
>>  create mode 100644 Documentation/translations/zh_CN/arm64/perf.rst
> 
> Applied, thanks.
> 
> BTW, many thanks to Alex for reviewing all of these, it definitely
> improves my confidence in applying them :)
> 

My pleasure! I am very glad that's helpful. :)

Thanks
Alex
