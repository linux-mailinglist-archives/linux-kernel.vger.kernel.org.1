Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71271254CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH0SXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:23:30 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46851 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0SX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:23:29 -0400
Received: by mail-ej1-f65.google.com with SMTP id d11so8908065ejt.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdlX9vgnoTMRIYbYspp2S5lK6lZM8ygrRr/wz3+jr+4=;
        b=hAwcv9Oz/7NybxPJqgiSkRAshGgpcvIbwZuZG3RPNrHYn0ISacyhhkkJyX3BbjratM
         1QUQkfAh+C1GngGiEsEmIcyDT43TkY2WBKbK7soSnVcRLCgiuiDY/k0DvqusiOr/oDF8
         1TUyd+o18aQohjASV8PfVcZqmjWxbsqaae5rR5nDP8gSRwyzWsgBzxJslhwfZZ05xBw8
         7FCGaiZq+yG++OvD5szyvaa9lzcsLsbFJvAZT1ohzv0UI4UnNAzuT4fqsd+PutJDSLYR
         vx1G5vbd2xNCgVo9FjpBPgUM9qVl1ZVaWBkhsbjfPy9xMyn6RgoUg4hssZtNc2wf04cG
         G7fw==
X-Gm-Message-State: AOAM532Kg5f4iT4ji6Ehhzv3yht9SiI+Xrw2zrFbWcu13rBQw99ElM+E
        bBw7b5ehDX0gDyn/E9PTg/c=
X-Google-Smtp-Source: ABdhPJyspVjh2FWHIe03309ISCWMbh8yVAd38TILVCAjjAV3Ekp/bNQElyveW1elCA5OmAA0HqZZ9A==
X-Received: by 2002:a17:906:eb4f:: with SMTP id mc15mr21740650ejb.435.1598552608533;
        Thu, 27 Aug 2020 11:23:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 94sm2121705edl.47.2020.08.27.11.23.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 11:23:27 -0700 (PDT)
Date:   Thu, 27 Aug 2020 20:23:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] maiblox: mediatek: Fix handling of platform_get_irq()
 error
Message-ID: <20200827182325.GA4548@kozik-lap>
References: <20200827073128.28389-1-krzk@kernel.org>
 <trinity-b7618ae5-0917-4595-81bb-51764215b02e-1598536674992@3c-app-gmx-bap26>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-b7618ae5-0917-4595-81bb-51764215b02e-1598536674992@3c-app-gmx-bap26>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:57:55PM +0200, Frank Wunderlich wrote:
> > Gesendet: Donnerstag, 27. August 2020 um 09:31 Uhr
> > Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> > Betreff: [PATCH v2] maiblox: mediatek: Fix handling of platform_get_irq() error
> 
> typo in subject i guess it should be "mailbox"

Indeed, thanks.

Best regards,
Krzysztof

