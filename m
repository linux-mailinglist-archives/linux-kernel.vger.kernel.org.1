Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE721AB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGIXOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:14:32 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37174 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:14:32 -0400
Received: by mail-il1-f196.google.com with SMTP id r12so3517035ilh.4;
        Thu, 09 Jul 2020 16:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YOfTosWvdo/xUF8oXi8DuuP0nOY85fYAm5dv/zsRHUo=;
        b=A6OlYEVHxsFJM2LoOnURehjQphL47R/YjVmfC5kN1Aj45FVGWD734g8A5wbpEj84cF
         MocudeJduJ4Xa0f4iYcIDU89NFJIYNC8xsdncPLL73AP6fZ7eiofoIDQ48sMlstqzNK7
         zP0zFIIJK1wAu5Ghg5lC1YKpDI1PuYovVaCJcPeAnGuQHwVtti6K1xZ8+0E2CJolpDNh
         QTs4HJKcOpGqTCLgnp4+ru6YAkiPVuZGfukCsY4oKc6+ZBF5/6lK5OlTo4pWMls3zsvA
         ai7HkYr7Ge1M6cqmsCEZVc0lenDWcjPGMPyBAVH/fvg5mKiK4NYxun5DF83vIEXbzxfZ
         ki6w==
X-Gm-Message-State: AOAM533+JMSyENM5c4IwTe4SXg0vCWtEzmm4aHpt2LhuspXyKFKcfKPg
        yFXXxm8Ln04CO/DbumQdnwcQwosYUg==
X-Google-Smtp-Source: ABdhPJz0uu3TJ4en/Ngt17u9+MVLk0V/LawcM6Pb0ptKIvYPbUY6rXhbu6u3d20kp4aH+qcfsndMzg==
X-Received: by 2002:a92:cc06:: with SMTP id s6mr50617518ilp.86.1594336471216;
        Thu, 09 Jul 2020 16:14:31 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id w82sm2678159ili.42.2020.07.09.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:14:30 -0700 (PDT)
Received: (nullmailer pid 1075154 invoked by uid 1000);
        Thu, 09 Jul 2020 23:14:29 -0000
Date:   Thu, 9 Jul 2020 17:14:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: realtek: Convert comments to
 descriptions
Message-ID: <20200709231429.GA1075098@bogus>
References: <20200622125527.24207-1-afaerber@suse.de>
 <20200622125527.24207-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622125527.24207-2-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 14:55:24 +0200, Andreas F�rber wrote:
> Turn the SoC-level comments into description properties.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  v4: New
> 
>  .../devicetree/bindings/arm/realtek.yaml      | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
