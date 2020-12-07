Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B372C2D122F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLGNeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgLGNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:34:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF48C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 05:33:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so12788745wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WiV9aKzm6lwVYCmypCKKQ4tQyshp2VXwQEgNJPS3aSY=;
        b=fiiU7kCJIS1fwXMZ/Y4AiQCoNLxcBUGEENzF805M22621y2UWEvdUHyuqwjNDAioxI
         sGyY+XctAthL2KbngQ3eek5dVHfewdr3O1OVgiy49F9CRtUqZkxmbX9fkqRzLM+LwZqT
         Zx+d5p0Tra9pYhR6asT0pLqxdAuX6dPT2PzDe47QXM4Pcgl/GPRJeNnkX6As28EycHLY
         4hlD1wzOuTobkzRv2pyINZGAhhy2cemdiaKWUPtHBlNV8Vi8vAsSa42EozOA9JYgUMlx
         lmjieysfsbihUEQjrNLMWdi7k8hJ0pphhMbDfyeHDox5aZ2UeOHFkN9Q3Cxc5/nkI9s8
         lP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiV9aKzm6lwVYCmypCKKQ4tQyshp2VXwQEgNJPS3aSY=;
        b=e/rfnwGVoKjjPbrh5OxxncQ81MOiYpQHJ805JtpxkJmTnYCwJFnZcLC+tqsSVh2vr7
         yH148z+S9Ss1XSyrRd4q1a5m/vVpkl307QqOl9ywxdO9wSyBl5vJf6rpoXejz+fji2zB
         UnLCyjKOMnJC4icR45eie9yuG13z19Jf8vAZ5sq5lUtODXQVQdJJfbeQbZpzvP7rcceQ
         6LfWIpA2w4YGn4cF5qaC5si/FMqjM6fY5jC+VD2wb1f+ObBdlYD8mxHtaebu2/W/B/Yd
         YfI6IiOXOn1DSvu4x07qz6ru5HkQtFsU7oed7LTCfkQZfm/FxWAO9jJ2pKN12wQDE1PM
         qq8w==
X-Gm-Message-State: AOAM532PazNjfHRuMRlGTlzitM4C+wCrSBAuNkXKO3X7B6I8rnpL/a/k
        P8GkbwXSky7DWMKHk2HuaLLvUw==
X-Google-Smtp-Source: ABdhPJzBDpE4RepsgrbJTZAXpxplvHylyspkmcuO/ulfp2pz1RIszbwYYd10gD9bJTG73UmTv4+W5A==
X-Received: by 2002:adf:c648:: with SMTP id u8mr19768308wrg.215.1607348012036;
        Mon, 07 Dec 2020 05:33:32 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id n189sm14250217wmf.20.2020.12.07.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:33:31 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:33:30 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] net: sparx5: Add Sparx5 switchdev driver
Message-ID: <20201207133330.GO3055@nanopsycho.orion>
References: <20201127133307.2969817-1-steen.hegelund@microchip.com>
 <20201127133307.2969817-3-steen.hegelund@microchip.com>
 <20201127171506.GW2073444@lunn.ch>
 <20201130131335.afasdxbf5ilhsxue@mchp-dev-shegelun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130131335.afasdxbf5ilhsxue@mchp-dev-shegelun>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Nov 30, 2020 at 02:13:35PM CET, steen.hegelund@microchip.com wrote:
>On 27.11.2020 18:15, Andrew Lunn wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> This is a very large driver, which is going to make it slow to review.
>Hi Andrew,
>
>Yes I am aware of that, but I think that what is available with this
>series, makes for a nice package that can be tested by us, and used by
>our customers.

Could you perhaps cut it into multiple patches for easier review? Like
the basics, host delivery, fwd offload, etc?
