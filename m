Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07228A66E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgJKI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgJKI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:56:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04684C0613CE;
        Sun, 11 Oct 2020 01:56:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f21so13846841ljh.7;
        Sun, 11 Oct 2020 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Av8iAeeJxUiyFO/5WdyIDg1zCHvYHT1L81w3SGv8akA=;
        b=kOgDEeS6BoOVfPvzdy+8ZqJ4Dw0PYzHZzdDTfdSjH+RnAcpJg6HNcLeppjjocH2af2
         ttICfqYhuH+XpMqcpXFJU+feojPisEiqHBCvdMsV5pOc331p9/wMLJVOUvExwTw8Js8S
         bRf/9c9FJ+lZhjeYASAAmPReoUFosLjbJnlK0Xped+o7R8s+KlOzyWCBEYK+NiYTqcBL
         ZGqL+GISx2gaRFc1b3cFpLWpCW38SfLa3rmHfIck9T4w3h16xOIEOk8BKE+GwWBFz1fr
         xapxoIU94QwUYcqqTKd6tWGrKFUVvgrfD5/vfQql8ENZg8h6LdLVOdCrK9Pj2L7eR1/f
         DEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Av8iAeeJxUiyFO/5WdyIDg1zCHvYHT1L81w3SGv8akA=;
        b=fiXgAKV4ZGMPf4mDA/+7klAV08dg0KOg7nr5w3g9kaYld3+oc3utlx5vEhdQ5PzG+R
         omohWUR78sga4gSgy0VvGAG6nMYVCmdAPUJR4ToA7HlYa3Nn9KUOiPETOBpZJNFz1vmk
         kIqeZR7fG9/yRsI+/ZmlraaNKRrPUTm9M0SP0GNyaKDXrcwkKA4MNqWQ60WgFmwBawTE
         7rzFGceFU6i73kf2sAGlXDn259WZyhGg7C02D1zLPGAG0enIE+lO71LcZ9PF2NdL6qCb
         vh7zFcTxWW+oilqz9FD6Xk3vYMYagP7lHPxZRv6tC6n9goQUpzQnGJUEVcUjoD0FWPce
         X53A==
X-Gm-Message-State: AOAM533O/g7Mv5mWYjUpUFoaNrJ52OBL6U0ICkf1jQUq3VxMPNyWRWy3
        CcAgegfIDTGowmrD2oxtV2eKHE+nfcXKww==
X-Google-Smtp-Source: ABdhPJx35lBDessle3fqVVBE1Qxfco3IimdGm/48RbiIgMJQXQhamZwV+P2ukrfdUZCsu91d7rbhVw==
X-Received: by 2002:a2e:681a:: with SMTP id c26mr8685853lja.56.1602406585182;
        Sun, 11 Oct 2020 01:56:25 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4275:c0a:6554:d910:ceb:9024? ([2a00:1fa0:4275:c0a:6554:d910:ceb:9024])
        by smtp.gmail.com with ESMTPSA id g9sm2450350lfd.1.2020.10.11.01.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 01:56:24 -0700 (PDT)
Subject: Re: [PATCH 13/18] dt-bindings: usb: dwc3: Add Tx De-emphasis
 restrictions
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-14-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <4b256e47-d058-a74f-0ad1-677886a03e74@gmail.com>
Date:   Sun, 11 Oct 2020 11:56:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010224121.12672-14-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2020 1:41, Serge Semin wrote:

> In accordance with the driver comments the PIPE3 de-emphasis can be tunned

    Tuned.

> to be either -6dB, or -2.5dB or disabled. Let's add the de-emphasis

    Either -6dB, -2.5dB, or disabled?

> property restriction so the DT schema would make sure the controller DT
> node is equipped with correct values.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
[...]

MBR, Sergei
