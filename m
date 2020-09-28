Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2127A7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI1G73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:59:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41535 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1G73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:59:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id ay8so98067edb.8;
        Sun, 27 Sep 2020 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPnuWUa+cjabnIx7ZIzBMUW05EELypIQJprVD0ZMD/4=;
        b=fGOSou/SE48LjdAPrI/dgzwWK9Sski7ie3UX2lRzKmF3HT7bE9zOQyvjgSqtoO15W9
         ltLeseajfnfDJqJZzvxqb55qlp8hCQfWqS+tOF2Llet4EchHljjp3UPcPMudarQ9WEmQ
         tK3H6gyqX3WMgAcbFlMxLLzARURbFp/kD7yaBlDwf7Hw9XBNFF3mbRW5xwFm3c2tBBQy
         7ny+ZPA0vlYOH2XFC7fZ+lJUWbo5YuOGDZHAEGd8dwdVSzNTbHx+UsvcfLVjNzPjbyyr
         82U/LPl4lIrxI+NMoN/XNavraX09Czm8QOHeDO1q6pFS32nRz+d+RDr0qY+W0doa/AJw
         JDcw==
X-Gm-Message-State: AOAM532S/78u8ExeFm5lp+FiVP2pSKShiezDavLnicV+wCmfDsKd+YhO
        /ovGLL3a91ODyccI+IrhZ1E=
X-Google-Smtp-Source: ABdhPJxexhXlWADOk8fZK2dRr1B3lFoBDsTxk/K+HW84++SAJntrOjkjzQntNpULX18gXz6ZimDb5g==
X-Received: by 2002:aa7:dc0e:: with SMTP id b14mr186696edu.17.1601276367572;
        Sun, 27 Sep 2020 23:59:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.132])
        by smtp.googlemail.com with ESMTPSA id ce14sm169110edb.25.2020.09.27.23.59.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Sep 2020 23:59:26 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:59:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, yibin.gong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: Add cpu-supply to enable cpufreq
Message-ID: <20200928065924.GA4676@kozik-lap>
References: <1601259703-28308-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1601259703-28308-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:21:43AM +0800, Anson Huang wrote:
> PMIC driver is ready on i.MX8MN EVK board, assign cpu-supply for
> each A53 and restore the operating points table to enable cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 32 ++++++++++++++--------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
