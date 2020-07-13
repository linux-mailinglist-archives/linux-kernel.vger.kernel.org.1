Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E921AB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGIXOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:14:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40867 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGIXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:14:46 -0400
Received: by mail-il1-f194.google.com with SMTP id e18so3481689ilr.7;
        Thu, 09 Jul 2020 16:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9/pD7cr8lRFB2QR/pjn1SXMs9QW8l4vbXZ+8xQ3OLzc=;
        b=DuqAGoWVbz02/y6hIm9mdF/kV2wJoLc9jT+rQyubEIz0wMDUkyhGyJuIQcx3hwtX+l
         mCU2tO4sn439CNB7kpDcFardN7cGeoPOSeW9PDBvQo16svOvHlWjT4rRoGpTOjGU2Ucd
         4X+O2R8ZkVGwgxSjfYQbD3w2WuzaoNDkiCGNBxwpLsFpXGntstkJLMoUeWIa65mRxVH3
         VDqGNXjm6Or0yg6uIp4hI4O2JHbZxa4PJkJOCuATXFI68OXEylaghuIOFcnFbJWxHLy4
         yBTVuz34eyAf5g4kQlLemYS9u+w2PwaQd0+bMzm43gNOhKePo7qGtAoNbtORXpG9J6bJ
         XaQg==
X-Gm-Message-State: AOAM533B3YbhhYziEhzOeX7wHGE7/kwx6cxZs9Ba/u2k8dXyz2Ne7+DR
        AO9zPXVgVt6CtCKlsPUCNg==
X-Google-Smtp-Source: ABdhPJx0VFnhwAIiq029Kxet6kqjRJ18m1i4k1getuY7Fb791BR8UoU+iRoeP8rmdEcDCahafE0TQw==
X-Received: by 2002:a92:794f:: with SMTP id u76mr45321103ilc.215.1594336485400;
        Thu, 09 Jul 2020 16:14:45 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m16sm2535338ili.26.2020.07.09.16.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:14:44 -0700 (PDT)
Received: (nullmailer pid 1075615 invoked by uid 1000);
        Thu, 09 Jul 2020 23:14:44 -0000
Date:   Thu, 9 Jul 2020 17:14:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek Pym Particles EVB
Message-ID: <20200709231444.GA1075562@bogus>
References: <20200622125527.24207-1-afaerber@suse.de>
 <20200622125527.24207-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622125527.24207-3-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 14:55:25 +0200, Andreas F�rber wrote:
> From: James Tai <james.tai@realtek.com>
> 
> Define compatible strings for Realtek RTD1319 SoC and Realtek Pym Particles
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Renamed compatible from pymparticle to pym-particles
>  * Turned SoC comment into description
> 
>  v2 -> v3: Unchanged
> 
>  v1 -> v2:
>  * Put string in alphabetical order
> 
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
