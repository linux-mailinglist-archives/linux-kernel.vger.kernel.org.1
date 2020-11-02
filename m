Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464252A3344
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKBSr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:47:29 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39664 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKBSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:47:29 -0500
Received: by mail-wr1-f52.google.com with SMTP id y12so15813580wrp.6;
        Mon, 02 Nov 2020 10:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dg9EShpcKxlJPUbHT3kMYzrq5qz/PbL6jzwabolFfdE=;
        b=Q/CL0Bna3yDS4ec/bnOLBVuysYvFtYmZZ6KIdJKr0+FyPSEnUMRcJcfvJujm6KHUHI
         8Uighjhj5WHpR6Tfvno6+ACkAkBq161GqXHn8GeNADxn17AMqJu65iMkhuZ54lwzDvw0
         Z+GX5a2A1C5S0Yv7anaNjeL33e1eMF3DHofbkR6FDZiM/KNSOiJOXRcSvZePFh1RSwNP
         PkojqDO93PJYnm3cxQxaMy5TnLY/Yc3hbPUTkvM6SDl1NjWtG9TSOAnRoVxVJJbyJI3J
         FvYkZ++w+mRhvZELUNNC8ggejMUkZkhAkclFyo3tQtqAJJ1kGHjCZFnmqRQootahhnTN
         cRCg==
X-Gm-Message-State: AOAM532BPkEgqrovYcfvzbD19UjVhqmIB4CgF73SjhghvEqL1BzHy/0D
        vGFYJCrH4u9KN/z8LB2IDFI=
X-Google-Smtp-Source: ABdhPJx5OKI4gIWQavh/Pw9YDmD4VTnBOTxroFyG0YjMx+yynudJQufTDn1TfqH6w2QLdcroPqiNuA==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr21286309wrw.120.1604342847708;
        Mon, 02 Nov 2020 10:47:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y206sm362603wmd.34.2020.11.02.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:47:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 19:47:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     trix@redhat.com
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: samsung: remove unneeded semicolon
Message-ID: <20201102184724.GA13405@kozik-lap>
References: <20201101152844.2290728-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201101152844.2290728-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 07:28:44AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/soc/samsung/exynos5422-asv.c | 2 +-

Thanks, applied.

Best regards,
Krzysztof

