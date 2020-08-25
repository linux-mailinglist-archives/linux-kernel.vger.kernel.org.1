Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AEA2516AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgHYKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 06:33:58 -0400
Received: from mx.socionext.com ([202.248.49.38]:29543 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgHYKd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:33:56 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Aug 2020 19:33:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 74DAF60060;
        Tue, 25 Aug 2020 19:33:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 25 Aug 2020 19:33:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 21F911A0507;
        Tue, 25 Aug 2020 19:33:55 +0900 (JST)
Received: from [10.212.5.217] (unknown [10.212.5.217])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CE5F3120131;
        Tue, 25 Aug 2020 19:33:54 +0900 (JST)
Subject: Re: [PATCH v4 0/2] Add new UniPhier AHCI PHY driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1594888344-32066-1-git-send-email-hayashi.kunihiko@socionext.com>
 <c60c0fc3-cb89-36e3-f18e-9a030ece72f1@socionext.com>
 <20200823132648.GO2639@vkoul-mobl>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <eb19c92d-0987-0c0e-93fb-8fb336cd7d26@socionext.com>
Date:   Tue, 25 Aug 2020 19:33:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823132648.GO2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2020/08/23 22:26, Vinod Koul wrote:
> Hello,
> 
> On 21-08-20, 18:20, Kunihiko Hayashi wrote:
>> Gentle ping.
>> Are there any comments in this series?
> 
> Sorry I dont have this in my inbox, can you please rebease and resend to
> me as well

Okay, No problem. I confirmed that rebasing the patches had no change.
I'll resend them.

Thank you,

---
Best Regards
Kunihiko Hayashi
