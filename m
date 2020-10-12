Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBF28B0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgJLI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgJLI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:56:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE9C0613CE;
        Mon, 12 Oct 2020 01:56:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so18203739wrq.11;
        Mon, 12 Oct 2020 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1u4emezYjGJikzOIjOej2YgBW0HERgDMRt0nLXGUm8=;
        b=s9KcTjuKhR7MuEXzaNG9QuNemsi0ODxvaNCiV2vLVA8EHcaqVegpbCGovjBWqSoTvx
         ZYfzX6BLPz7MoRp7zMXh4KyMrQg14jwkFprMQIG0D6awkymJ1YWaSa2cLKsv7wLswZPd
         JnaeNV2yg2/wbHNUtQoI0oc1xGvk9YYKUQGA4S2R6vzn57rrkOxCLPg3W+yJyGtJGisB
         Yq5afgr8jWxnND+6Hsd6yeC8k2jWChKjWgPCiWfEYlivZL2c3MN1f1ozyGpewkgL5J2t
         CFfTaSrmv9J0vKjBVLiaiqf6ZqrJ/0AEOJjZWO05xlCKpAlt9It48EIp3yrgWExSmtoE
         Yt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1u4emezYjGJikzOIjOej2YgBW0HERgDMRt0nLXGUm8=;
        b=B0oqL+ctmBXJGbzqkpjpCQgISqCOUiL52SYRXkVeCQxioI2HXfEIJl2RFXhecHg2u1
         xfIQc+p3upORimHTbUaiMqm8DIb4w5MZ+fj+dN7r8OvlL5TbgzPHPxvfAoe3lc4cVZ+/
         k2EreZ4v0HrhTCaXgynal7s+KRzFgl+ZMUfhLgQpDGRopx+F+2WOH/HUrbTul2fSk/OW
         g+nlqbuo0PVr8NZyWADBPQx9fNi1KdMYqK23DFS42o7LMMHxImhbfLOUJ5iCZAd2cMdl
         jUdrf32LEMw1hzZq5YNmupgbkM2TQ0vcUP6c5EmEflCaTIG+dJDv9+OKdbn10nTSvIlI
         lYVA==
X-Gm-Message-State: AOAM530P21LX5TTmIlhIGPTl/EbjfakU+NRolqS+lZeXnyU3ITR7e9rC
        fPGC47hLCMZc0zPrgMc+nlo=
X-Google-Smtp-Source: ABdhPJxuQ7YErQZ9fjpv33N0IkIZklG8+ghTVD9H+yWD2rLNPPA4r8lJNvPb3ZpJ/WNu9P0VnFrjuQ==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr7297442wrm.263.1602492960308;
        Mon, 12 Oct 2020 01:56:00 -0700 (PDT)
Received: from mamamia.internal (a89-183-93-7.net-htp.de. [89.183.93.7])
        by smtp.gmail.com with ESMTPSA id s11sm19741751wrm.56.2020.10.12.01.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 01:55:59 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
From:   Andre Heider <a.heider@gmail.com>
To:     Vladimir Vid <vladimir.vid@sartura.hr>, devicetree@vger.kernel.org
Cc:     tmn505@gmail.com, andrew@lunn.ch, jason@lakedaemon.net,
        gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com
References: <20201009152710.316047-1-vladimir.vid@sartura.hr>
 <f911338f-17c1-bcbc-0ffd-a8b97de990d4@gmail.com>
Message-ID: <6a09546b-9a58-1944-628c-33023c720a94@gmail.com>
Date:   Mon, 12 Oct 2020 10:55:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <f911338f-17c1-bcbc-0ffd-a8b97de990d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 09:08, Andre Heider wrote:
> Hi Vladimir,
> 
> a few comments, all by just comparing this device tree to the other 
> espressobin files.
> 
> On 09/10/2020 17:27, Vladimir Vid wrote:
>> This adds support for ESPRESSObin-Ultra from Globalscale.
>>
>> Specifications are similar to the base ESPRESSObin board, with main
>> difference being being WAN port with PoE capability and 2 additional 
>> ethernet ports.
>>
>> Full specifications:
>>
>> 1x Marvell 64 bit Dual Core ARM A53 Armada 3700 SOC clocked up to 1.2Ghz
>> 1x Topaz 6341 Networking Switch
>> 1GB DDR4
>> 8GB eMMC
>> 1x WAN with 30W POE
>> 4x Gb LAN
>> 1x RTC Clock and battery
>> 1x DC Jack
>> 1x USB 3.0 Type A
>> 1x USB 2.0 Type A
>> 1x SIM NanoSIM card Slot
> 
> This one isn't enabled, is it not working?

Nevermind, I was reading "SD card" earlier, duh...
