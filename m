Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344A1E6D04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407458AbgE1VAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 17:00:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34947 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407396AbgE1VAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:00:07 -0400
Received: by mail-il1-f193.google.com with SMTP id a14so381178ilk.2;
        Thu, 28 May 2020 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9/zXo1D/MaHPT4W5dtBptKFjKcNZZ5DUc8Iw936Zdg=;
        b=jk54fGZEG0C+EwMxg9g/IFIDxkNUb7BNpEC37W5a9WocIGGbSGULnPObAky1eE6Bar
         Rwh7SFp7zPGfqgfULn7rpVWE8w2SdvB+/WH6ZK9jx/4ThV5sfO5DhG5SHB+Xbh9hRb4M
         LZUtBJ710seW5faTuhRpW1xGQL2t14XCrevmImGXEp2icDe5mSdq9LTBhvVrfRjfVyHe
         OuGWV0DKUwBPTnfsaFVPjMrawGrs7GIddXB85tVRGh9QsNM4knYCdYCxlHZ3Eydj9327
         W9F3TjUb23xAmnrJyEmT6jpIbrAoW8dEyKP4p9VVz9z4nW7iuGN2PKHHLMXuxwRZsM2b
         weSw==
X-Gm-Message-State: AOAM532mP+9ViuoRiN7sun91hQ43N4et9QkI3+1Lwelyp2lxtpLs+Zy2
        /o+3eFlRYtRqsOBF7RbJfQ==
X-Google-Smtp-Source: ABdhPJxGSDGqe1jHsfiIWe7poFysMf6a/HV4i8103L/vkn9OHjEfZF/3cHeecQok/kGcda130WSE2w==
X-Received: by 2002:a05:6e02:965:: with SMTP id q5mr4481965ilt.272.1590699606434;
        Thu, 28 May 2020 14:00:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k18sm3038277iok.4.2020.05.28.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:00:05 -0700 (PDT)
Received: (nullmailer pid 666474 invoked by uid 1000);
        Thu, 28 May 2020 21:00:04 -0000
Date:   Thu, 28 May 2020 15:00:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, daniel.lezcano@linaro.org, ping.bai@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        shawnguo@kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH V2 3/3] dt-bindings: timer: Convert i.MX SYSCTR to
 json-schema
Message-ID: <20200528210004.GA666410@bogus>
References: <1589860547-3207-1-git-send-email-Anson.Huang@nxp.com>
 <1589860547-3207-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589860547-3207-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 11:55:47 +0800, Anson Huang wrote:
> Convert the i.MX SYSCTR binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> No changes.
> ---
>  .../devicetree/bindings/timer/nxp,sysctr-timer.txt | 25 ----------
>  .../bindings/timer/nxp,sysctr-timer.yaml           | 54 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> 

Applied, thanks!
