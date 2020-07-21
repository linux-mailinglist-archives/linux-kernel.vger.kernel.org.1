Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD89E227573
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGUCMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 22:12:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37361 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGUCMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:12:40 -0400
Received: by mail-il1-f196.google.com with SMTP id r12so15097023ilh.4;
        Mon, 20 Jul 2020 19:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0xPj1Ho5fgI9khsratqKQQfk1V9sIVhizjOEkVa748=;
        b=cGhyjAWfGioRDqxPPsVTH1u/+cRblJQbUph+6nEGQk4qkGHWjfPgtpHmgIgVH4WCi4
         qacPHI6YuOBT8U02VYORkqu0e3apOeZVdbJyYs7LBccLU7DR1gAxYtDXy6JArqpI6pvk
         bH98c7K9ByHyEsJvgjqLqe+2XcsMnsIUeO90NTJV2NSElaC/NWCIoc1EtfToxDkU/UOT
         NWoUzN8uDq1AjWKjqlI9T5STp0ik69ZCkcSxyHDmLL6IiQfYITKN1qo910hLHUnkbXof
         hXPOCnHBaNCSSJCFKVD4QSBqpeQ9EtES0rA55HNu2h9Ufi+d7a/F5syOZ4Rcy+n+QUvY
         Azpg==
X-Gm-Message-State: AOAM532/OxFQZNwuH2lBYK3rdc9xsg9pr5mOFvUh8Z0ekirvL2JKEYnH
        8fVX+2CPHpppXXYPQykeBw==
X-Google-Smtp-Source: ABdhPJxc5qAtpL5dkkvN8ISGEBQRIsmkLgRH1g0yx9Vu3KumL5n3keb5UonNgQK+wNW9RJA4XJh0eQ==
X-Received: by 2002:a92:bd0f:: with SMTP id c15mr24981493ile.95.1595297559165;
        Mon, 20 Jul 2020 19:12:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b2sm9841835ilf.0.2020.07.20.19.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:12:38 -0700 (PDT)
Received: (nullmailer pid 3391247 invoked by uid 1000);
        Tue, 21 Jul 2020 02:12:37 -0000
Date:   Mon, 20 Jul 2020 20:12:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mediatek: add compatible for
 MT6873/8192 pwrap
Message-ID: <20200721021237.GA3391199@bogus>
References: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1594720432-19586-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594720432-19586-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 17:53:51 +0800, Hsin-Hsiung Wang wrote:
> This adds dt-binding documentation of pwrap for Mediatek MT6873/8192
> SoCs Platform.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
