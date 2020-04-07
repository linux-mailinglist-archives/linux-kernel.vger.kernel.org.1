Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC311A0736
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDGGZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 02:25:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37154 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:25:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so2620113edb.4;
        Mon, 06 Apr 2020 23:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWP8ALb8wYdsD/O1VwXXZ9+3UCXLB5W7BFN7aFIDKQw=;
        b=fJKMdEGqn9KkkjBr52E1odwqyhOJmf2oL1KLI71E6w3UmFFychNDhN0L5GrIuknLPe
         QJoIq0TINxcdVmENWJHRBuQ0cHYrJai3qHyOi5wSr6HBnr5XOqy5L425ZNxzMnrjQd3n
         0tO1FYPK+DGI8Qc8E+LIHiXphr2+0CalytF1I6JugFekboujWpoNMrsd5x4Rtlfu/V+b
         urKYNkRfv+lQMZR2ClxXnjFq99sc22U9v6z4rhpQU2sRq2a5rBdPH6l80sBpStBBVKT7
         fIqzKX0Vqkxn9XSaD1TvNl3Farw3D22DB8fEykOq3X4CsEUEpKpaRN693MzmN7zqLlfV
         EtOw==
X-Gm-Message-State: AGi0PualIsUpzmu97UKIWAnMsRGW6Da88ZrsmIuz7moqkiifA4tC0pJk
        eIwpYa6lIgHnnYbCB71qPwU=
X-Google-Smtp-Source: APiQypID834IQhpqxcgpsAT1dwx8uHhadcT8Ewrwr2+fzKup+mIyoIYqHlR3HdcKjkyEHaVagZaeTA==
X-Received: by 2002:a17:906:504f:: with SMTP id e15mr521953ejk.45.1586240745817;
        Mon, 06 Apr 2020 23:25:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id m1sm773164ejr.37.2020.04.06.23.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 23:25:45 -0700 (PDT)
Date:   Tue, 7 Apr 2020 08:25:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add reg-io-width compatible
Message-ID: <20200407062543.GB21995@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com>
 <CGME20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f@epcas2p3.samsung.com>
 <20200406230855.13772-2-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406230855.13772-2-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:08:50AM +0900, Hyunki Koo wrote:
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v5: first added in this series
> v6: clean description of reg-io-width
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Please keep accumulated tags (review, ack, tested etc.) with new
versions of paches.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
