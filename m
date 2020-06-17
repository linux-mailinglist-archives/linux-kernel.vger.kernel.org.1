Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342451FD7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgFQVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgFQVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:40:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770FC06174E;
        Wed, 17 Jun 2020 14:40:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b82so3284945wmb.1;
        Wed, 17 Jun 2020 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=efeL2ymDRArA1GXEtiNeJF2lhasTeMgLsuNXEb/IKPk=;
        b=XnQDm7Va9MlH8z9cC/AwVRu9neWaFC48Dqyxu8WbE2c7Y0kWTbtHr5ff+0m+uJACX2
         fa13dA2Dnr3Ha7b9jGNNJzOe2Cq/lMyD5LZESSdL7ac6018fvXSJAVb035KnFfsBn3tv
         k6BMdpeFlCbq2JGoDmr9itei6P7Ln9D9W9K2YYVSLHdKiqx+nviUJT32r4RwJMZYRpj8
         B2nMWmebfiAKUQdUVWybAhbtX1FK7JfsPY8evKU+cqtQMRc7ow3dTWlNs48s2t7WTGpL
         +oqcLPzPeCrAoHAXyq/f/YhbTTTYslzx+oGbms0oz9MtcE3ttHr4nI+y9ljKuail/zxZ
         28Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efeL2ymDRArA1GXEtiNeJF2lhasTeMgLsuNXEb/IKPk=;
        b=rmZLSwZMNliNCon4uCqu3KpW3Q6HaEggQIQtI3OIS2We+QYTVKnNKfLuKUKA1ulGgC
         F0BOzKWLyEvMCP/lNcbGUznBRqkKw+JNpUoLWqbTL/8PMNOKdERLDmSo1uWFxySEsPU4
         9R6/APq7eDgHVce98YhhqrZ6P9Z6oTB1qmiGsWJOhqy8b+7gEuqL1Ejloj0tm6jlqDJM
         7gYKuSB8nCPRkkHkqOOcyc1lI1UoGd5DNL3Nemfg4lrxxjK2TC+ECSzV5f8ULNDexPzu
         moO7kZcriWn5YR5//lBg311CMdWhLfCzHXidHmaiI+sBUsyR2BJP7F4farmokWXDhzRH
         vwGA==
X-Gm-Message-State: AOAM533qUCCnW0veuu8SXvpTgCBaubjs9rtYoTrpwJTszohLjY81gUR6
        0kf4WiBoJYqO9tWIC/3PfJolDDvT
X-Google-Smtp-Source: ABdhPJye0zCbpMlRaVUNwL4eMMpYbrbcI+mSiIxK/kpN0bISzf3wKjqkXclQmWHsjv02awHVbGdQ7Q==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr692572wma.160.1592430039675;
        Wed, 17 Jun 2020 14:40:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x14sm878438wrt.60.2020.06.17.14.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:40:39 -0700 (PDT)
Subject: Re: [PATCH 7/8] mips: bmips: add BCM63268 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-8-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d1e3224a-ea06-204f-eb13-903361ed5da0@gmail.com>
Date:   Wed, 17 Jun 2020 14:40:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-8-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM63268 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
