Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB02DC682
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgLPS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgLPS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:29:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA2C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:29:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n26so34142333eju.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erIoBEbKbiz5oRvHJ2Hn0NTy908E7i+ePDr/KDJfqn0=;
        b=RQQ5ktXzQkitjNrDXhSj68Nk76iCrFiuj/7rR8NhYWibX+TJEUAZ1ABRoLCFSvSyhD
         K+XSzAJ8+JptHtbXZgAMLd0C8CH7rASXoNDM/suXiZSey8fRstAT7j/a3LBA4Z/ItkcW
         1KLlUTyufegGfHsfw6OASMbx35T/dOUZh2n2DtwPkjnY7UvC1lGopN435jaOCu9sLQRC
         d+0ogLUP8B1gq+H/wdjWWd1r3jNt330yGJXpKDpBReCXvcZc0s9aGyzV4dq/pX7OCHL8
         DrffsY8AoJZdbDgf3GUaosn01KgA5PC0mG+pQYhmh8NhXGU0wbK+OS4rc88M46Z8G6Pg
         yO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erIoBEbKbiz5oRvHJ2Hn0NTy908E7i+ePDr/KDJfqn0=;
        b=BxC9VpkEw2h1fwPVSgUOqYUTKqr7HNkeGaVG/c38nFowjcD9tvcPl/L5537vOiiBf1
         6c3cm3vd7cI77N7RMQcjyefMgiOYPA1HlVW8QfTUzYVWroHTRliTRRHXrAI593r2h/6w
         aZ22gUhPP1Fx+dH/N1OdZ+MpYjlyKs4SNtI9r8KqHLA7ImBzY/NjbAW/PnpiTz5Smjji
         rkpZo47K8+WHJLpbQjyA0g1gkY7fR4D7a8xCwTOk6H0dfRRZTeOCq2IqvRROcIOgLF9X
         vezk12lq1MvvJUALjJFX/EXL7i3zGoxWkDAJvVNj9EpdE9FjADrf1pVk1JTaurEc2kQy
         +8Pw==
X-Gm-Message-State: AOAM531ny8M6a0cZ3Ac4pgaYBtKFl6Rl9KXzruLS+cNmKDn1YZ7NvjMN
        4bYmTnxQ19oRzAZgwHsiRUzS9BD1XShH3rvB
X-Google-Smtp-Source: ABdhPJwYrZeKblL+48+EBX3qrAEooomDWvRk7xg3KKtcF9HUnU1fmEnVGyTYAjoEyim5ZUFQy/DxOg==
X-Received: by 2002:a17:907:da7:: with SMTP id go39mr33278642ejc.58.1608143352040;
        Wed, 16 Dec 2020 10:29:12 -0800 (PST)
Received: from ryzen.localdomain (89-212-27-98.dynamic.t-2.net. [89.212.27.98])
        by smtp.gmail.com with ESMTPSA id v9sm2032877ejk.48.2020.12.16.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:29:11 -0800 (PST)
Date:   Wed, 16 Dec 2020 19:29:09 +0100
From:   Amadej Kastelic <amadejkastelic7@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/01] Add VID to support native DSD reproduction on FiiO
 devices.
Message-ID: <X9pR9X/uCqoij1b0@ryzen.localdomain>
References: <X9j7wdXSr4XyK7Bd@ryzen.localdomain>
 <s5h8s9xoj6o.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8s9xoj6o.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 04:38:07PM +0100, Takashi Iwai wrote:
> On Tue, 15 Dec 2020 19:09:05 +0100,
> Amadej Kastelic wrote:
> > 
> > Message-Id: <c759bc50134ea434bfed0a183e0ce72984f5b609.camel@gmail.com>
> > 
> > Add VID to support native DSD reproduction on FiiO devices.
> > 
> > Tested-by: Amadej Kastelic <amadejkastelic7@gmail.com>
> > Signed-off-by: Emilio Moretti <emilio.moretti@gmail.com>
> 
> Could you give your own sign-off, too?  Each person who submits the
> patch needs the sign-off.  This is mandatory for merging to the
> upstream.
> 
> 
> thanks,
> 
> Takashi

Signed-off-by: Amadej Kastelic <amadejkastelic7@gmail.com>
