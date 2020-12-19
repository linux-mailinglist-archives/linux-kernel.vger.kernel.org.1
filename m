Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047F52DEEAF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLSMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:21:08 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:36589 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgLSMVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:21:07 -0500
Received: by mail-ej1-f46.google.com with SMTP id lt17so7080371ejb.3;
        Sat, 19 Dec 2020 04:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQIvH/EaojZr30I+ojSaU/XVWSsb+OmSdYHU9u+PQH0=;
        b=E6hLgJATX6y0Tfp4EpYM1ryge4xZFiQ6TwIBcwt2jsYlO8gZ5bfEcRtQMqE5/w9nLo
         QYctHPZ/3QKKYy2GwUOSAGGo1VUGvfw+EstzsH5au2Gwg7edwJnJynZYp4QA+t9JIVZJ
         Aitq5SnUBUlpLXEw3YCwB+6tfBKvCaXUXLHQ64HJtUeBh6UPrk0Un6x7LQORpb24SxaK
         GktzD9gHBFApSLlyVeXC7Ayuo4jImL+wlfE/W8XnduWP3Qat1FQtjTJBEqshuHjRGaNG
         pJci7m4B4lIr7ZRTitlzzNHlUEgMrY3FI+dfifXHRZyoUbN7Rox5+yYwpkXnyPprbrre
         yadA==
X-Gm-Message-State: AOAM53147Chu5SfyllsYmgFGVgMROMl7rRYQFDFaXya+PasCuy/SP2IT
        D+NKN5lmpFqI8GWkYtWQS3s=
X-Google-Smtp-Source: ABdhPJzufUc6zhZ6HvuRwkeiDRkdw2mm9ZxrV05vX6HycaLqM2UKDHr1Ii2jh3tH2O/jPNDihGoc9w==
X-Received: by 2002:a17:906:94d4:: with SMTP id d20mr8077310ejy.475.1608380426054;
        Sat, 19 Dec 2020 04:20:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r7sm19396916edh.86.2020.12.19.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:20:25 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:20:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the
 touchscreen description
Message-ID: <20201219122023.GC13886@kozik-lap>
References: <20201218103131.22013-1-martin.kepplinger@puri.sm>
 <20201218103131.22013-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218103131.22013-3-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:31:29AM +0100, Martin Kepplinger wrote:
> Add the pinctrl description for the interrupt.

Please describe why do you need to add it. From the patch contents I
easily see what you are doing. But neither the commit title nor the
message describe what you want to achieve (why are you doing it).

Best regards,
Krzysztof
