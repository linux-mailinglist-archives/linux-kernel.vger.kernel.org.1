Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B7281789
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbgJBQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:11:34 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:39118 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:11:33 -0400
Received: by mail-ej1-f66.google.com with SMTP id p9so2735266ejf.6;
        Fri, 02 Oct 2020 09:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ksDqHk0nWP4nQljjtYaRrFAhIWD1+rfwypaFmgT3k94=;
        b=Ehvl2uo62aYZP2XejOeTP1XyrDTwO04hv02BtViUdMb2zY/WpmJXKQ3etiIHr44JLr
         CvuekS8GaJxZP+WXg6lZ3qEfdQ28l55GKxKwVVqW228UgWmC6hslCy1S1jzdSC4d72Tz
         ORGUYS0TRXDGbHTh0+JlDn7mXFVkxUwDf7jFeOeziZzZgfUgM2BQULudNscSXeNlL2ST
         Xt9ljan9SY2HZCbxj/7QFWLAjlX7U5gt1jKthtVMLYqeMGF2dFEIzNipoLLfzXFwsqvc
         IKs0jr6Qn/95VMgTfjWFMSFbc/kEhW8Z1/qAT2k+kl4S5YpKfKeeaTFw6DFh4CwOXKBx
         zPLw==
X-Gm-Message-State: AOAM532BWJWEPFEx062te2DxQSCduso/fm8gg2xOYGHwE2Rgr6Ft6DIV
        mff4jAxxx+rt4ay3A3Y+sm8=
X-Google-Smtp-Source: ABdhPJxaoL9cJDAS/3KTQCq9OR55V0vP40AWHy9tKAmxl6vL/n8LS8/lhHN09AET7FLTvZ3xFZ2RMg==
X-Received: by 2002:a17:906:ad5:: with SMTP id z21mr2873895ejf.461.1601655092107;
        Fri, 02 Oct 2020 09:11:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id t25sm1481672edt.24.2020.10.02.09.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 09:11:31 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:11:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: rk3188: correct interrupt flags
Message-ID: <20201002161128.GB4542@kozik-lap>
References: <20200917185211.5483-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917185211.5483-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:52:10PM +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags without affecting the code:
>   ACTIVE_HIGH => IRQ_TYPE_NONE
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Not tested on HW.
> 
> Changes since v1:
> 1. Correct title
> ---
>  arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi,

Any comments/review/testing from Heiko or other Rockchip folks? Shall I
cc here someone?

Best regards,
Krzysztof

