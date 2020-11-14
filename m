Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449442B2E42
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKNPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:55:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgKNPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:55:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so13694071wrw.1;
        Sat, 14 Nov 2020 07:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzDYo5okVHCmYM9a04iDT562s9pozf0uDZlfSqnFdeo=;
        b=gUHEMWOH0Fxv0KpjBefZkDvsbt423ewHZOojfjxeBwYO+JEEQ5W2XywItxGdfAz/bn
         D1p7FvOhGB74UQbU0FDRRfyr39gB+e0VL82GvdYcKtY/XPHrrlxeHQf9qAKgfiA5KCQ1
         p8NF85kQUIHfxvzfxGH8sxnCG6M0+FqBUmtLFsZlu8XXQ3Tprq+jO6I5s9kzj+I1L0QY
         TEe4aEUzfAH8p+p2Cva2YBXc7OtWezmpmDdZv+zbB81+UZ45f3KmXDr12TcpUtGWxa72
         PMV2/Jrn+A+F27KrIr2Ld9ysyKqKxUgMuAUk4J11m18mBypSxa98BDtcCE/HKIhkP+v9
         VMOg==
X-Gm-Message-State: AOAM530GeG/ht/FQaSmwV5lqpgRuoASrxsrot8qDMYrNcqIC4uz9sZ7I
        SjHl3G0utKQPd9lwRucX2MM=
X-Google-Smtp-Source: ABdhPJyYstJ6HNafjOg1KIWidr6IZURyZd7lXmkZsadLuQ7YOGEzm+tYPABeb7IeMD/dUtdLtHv7Rg==
X-Received: by 2002:adf:9104:: with SMTP id j4mr10988042wrj.198.1605369312567;
        Sat, 14 Nov 2020 07:55:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y187sm13990854wmg.33.2020.11.14.07.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:55:11 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:55:09 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201114155509.GA14989@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113110409.13546-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:04:06PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 

Please align the subject prefix with history (git log --oneline).

What are the changes comparing to v2 and v1? Where is the changelog?

Best regards,
Krzysztof
