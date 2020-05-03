Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222DD1C2DC6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgECPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:55:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45460 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:55:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so6725823otk.12;
        Sun, 03 May 2020 08:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnLZYZwMU9atoe0Mo9BQCXr6qSWkjNa8GKSdfV9HOXA=;
        b=lJ1U6SB1pEGFxa+I46zLgsAzlo4SmPPIxjIWpYTulKhA0FpEm0EvW1UUfTJVgFlknJ
         VJWDqEYi1cziomTLUWT8LzlcaWoI7ViuCwzDj68Lzwpr18DBc63TVZ6y4tQcg4i7dNDv
         KBXy4pqADkmdhcr+dt0JVxZrEVluvvqZZbZsLNpxeIlei5tju9denLxtHs6B5B/Kv29E
         vZYbZk7hiL80NB6/zySjQ6mu1SCz7VKhZjpwBfePWI4rn4pDDqnQvp7RewHTiPeUkDvr
         4FgM7OLoJ8sqpGB+RtPbi8OsVCOCBufKbqpMok4iXrTtqcuQ1Uq6wgREk3aJgKxkLMic
         Oa4w==
X-Gm-Message-State: AGi0PuaIO2odUnc2QgevzNbTj65kZmjQCCfuY7uQAF+sJ2wA51d9d2MR
        ehwJioq2uFju4NCucqUmEA==
X-Google-Smtp-Source: APiQypLsYrXG1Iq51+4SYgbvtQ3WEYsI6WitaRslxP0Mw5idOuiEJPlplpaXc8z0qAv5muN1T2BZAw==
X-Received: by 2002:a9d:4102:: with SMTP id o2mr10936464ote.98.1588521352740;
        Sun, 03 May 2020 08:55:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j14sm2534258otk.27.2020.05.03.08.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:55:52 -0700 (PDT)
Received: (nullmailer pid 21349 invoked by uid 1000);
        Sun, 03 May 2020 15:55:51 -0000
Date:   Sun, 3 May 2020 10:55:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: arm: Convert Calxeda L2 cache
 controller to json-schema
Message-ID: <20200503155551.GA21293@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-6-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:51 +0100, Andre Przywara wrote:
> Convert the L2-ECC controller binding to DT schema format using
> json-schema.
> This is indented to be just used for error reporting.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 -------
>  .../bindings/arm/calxeda/l2ecc.yaml           | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
> 

Applied, thanks.

Rob
