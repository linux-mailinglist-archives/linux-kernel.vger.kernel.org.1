Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549C1A6B46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgDMRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 13:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbgDMRTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:19:11 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FC22072D;
        Mon, 13 Apr 2020 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586798351;
        bh=cOHgDLG2OEFMbA+A0xqNSmIjg/9Q/4+VZgYjP32HOK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvkMhGDzbkQJ5IvqSsLJMy9CWA6UNG4IxfMvS+UoFAsU+UEO9UNkS9b4YcZRdQ6Bk
         vhcfTLFDkgguW6HkI5Ex8GY07MxcpUl3o6V6yBIgeg8hpaLIzcNX5Mkk3yhuWrLuK+
         uZul8kU6tCSbErGxg5cODhWOZynWgcEIdPYFLRWg=
Date:   Mon, 13 Apr 2020 13:19:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mohammad Rasim <mohammad.rasim96@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.6 11/68] media: arm64: dts: amlogic: add
 rc-videostrong-kii-pro keymap
Message-ID: <20200413171909.GP27528@sasha-vm>
References: <20200410034634.7731-1-sashal@kernel.org>
 <20200410034634.7731-11-sashal@kernel.org>
 <20200410060712.GA13759@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200410060712.GA13759@gofer.mess.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 07:07:12AM +0100, Sean Young wrote:
>On Thu, Apr 09, 2020 at 11:45:36PM -0400, Sasha Levin wrote:
>> From: Mohammad Rasim <mohammad.rasim96@gmail.com>
>>
>> [ Upstream commit 806d06161af045dba29f3c7747550c93b2ea3ca9 ]
>>
>> videostrong kii pro comes with a nec rc, add the keymap to the dts
>>
>> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Sean Young <sean@mess.org>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
>> index 2f1f829450a29..6c9cc45fb417e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
>> @@ -76,3 +76,7 @@
>>  		};
>>  	};
>>  };
>> +
>> +&ir {
>> +	linux,rc-map-name = "rc-videostrong-kii-pro";
>> +};
>
>The will need the keymap itself as well. It was added in commit
>30defecb98400575349a7d32f0526e1dc42ea83e.

I'll grab it too, thanks!

-- 
Thanks,
Sasha
