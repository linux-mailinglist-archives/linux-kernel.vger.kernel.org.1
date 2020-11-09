Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CF2AC221
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgKIRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgKIRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:24:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26BC0613CF;
        Mon,  9 Nov 2020 09:24:23 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id z24so7723126pgk.3;
        Mon, 09 Nov 2020 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EAL6WgwH+DlWmCjz1UKr8/3O7oBbbS6rnPaBXOwFhNk=;
        b=JpKzLk5XVSpezsnZCQmIKn6atArQGs0YyaDT23asnJWv1qJi0PPmjantdPQcd1ols6
         oDNLUjDQBr44FBur6XE0URELwXSp8elODKmmsvnNZwvQpTsriRgAGR8rZaXPUi0lLjaJ
         9fTZZIb7uyfgJqPnT7NWn10WXjaRImLSHxgAacq2QR++/2/h0KfT+1YjD1HRFze1AziN
         cXt5Y9ojJt5RKcde+aSEm+lBCzPe70puLFuHSi7v+6wigMOzjQyz5lD93aR3r7YD97B0
         0a0ag3QBl3nioGnW/08Zb1E5e4yCTd7lBP7Oa8YJKyepERsog5P0IaWMjU8TNRi23txc
         Urlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAL6WgwH+DlWmCjz1UKr8/3O7oBbbS6rnPaBXOwFhNk=;
        b=SdoMJ6mfuwcMgdcP5yM1VlnL4PvLsQU1g3kP7JqfgDmhqTJIRWOoUxMx4AWHPYaBhB
         HcUdJKiU3R6orUhBRJSB8thgt+Q6eOnQc5Rl0KSJ2aKRUwNHbtQUcWkobOdRRz9fiem4
         DcA4m3X3D6gdD7xP6bsxI6bAIQUqLySNJ6WoHh0PMwMo3CVUBfeyxa/kpSZXYTHOX2Zx
         /x2Z1wFDIoZzMRAqKX9FKWPsh9MSjyPyVpcdfHAJgkPv+4tvjKwmI+wJxgXIYu/cs0BJ
         SlLKJcpBWrCitjiYXpiaF+HoC/9nTSxVNl0gmjhfCe/EZWC3mjELc04FLPqTTePSbtAe
         BAMA==
X-Gm-Message-State: AOAM530qqvYhg/K2h9PCi0y/RMRDzicg3Y5Uc9I5UPxw5+r921XHznpp
        xlW2S8R4Q5GhiqM37fNcibc=
X-Google-Smtp-Source: ABdhPJw9Q+JmJ+TwqxdTamzWMBhy+UI0Hfm1LZbpC9Enl13z9tyhjpJcp7TCRohQZqq0licvUkNaxg==
X-Received: by 2002:a62:fb12:0:b029:160:4c48:b9e1 with SMTP id x18-20020a62fb120000b02901604c48b9e1mr14186598pfm.8.1604942662902;
        Mon, 09 Nov 2020 09:24:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o67sm3105769pfb.109.2020.11.09.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:24:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>,
        florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
Date:   Mon,  9 Nov 2020 09:24:20 -0800
Message-Id: <20201109172420.711965-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104202952.783724-3-npcomplete13@gmail.com>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com> <20201104202952.783724-1-npcomplete13@gmail.com> <20201104202952.783724-3-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Nov 2020 15:29:52 -0500, Vivek Unune <npcomplete13@gmail.com> wrote:
> Now that we have a pin controller, use that instead of manuplating the
> mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
