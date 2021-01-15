Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D072F823D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbhAOR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:27:10 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43755 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAOR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:27:09 -0500
Received: by mail-ot1-f47.google.com with SMTP id q25so9228750otn.10;
        Fri, 15 Jan 2021 09:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxqs5G20PgCiX7UtPfQqVpcyNBLKErUlmmUfzEseQUc=;
        b=tTYd7gkhPZ/mHbTzLiKwNZfO2aWlutgA0KmosaIga2lC8X0DS2njPMQGyM+Yzy8EdU
         s++Cga8ptz0AjrKFyv6xEFXfgwy0vLO0WPlwLAXvQhyKeH/CbwTxFJGNg+bWvyZVnwQ7
         J29zR7ESZEMk/lje1x1vA4Jxmn9+4dtXBmbosA1rubUcYFH2Vsw8Ysn+QMfcNBFNd0aM
         0mwOIBQsw/gayLGTB6iIKuyCma7ahLy6/4bBFlECl0XcBspKI7VYIqgcXrtP5GOg19UZ
         W6m1nhj4i+0110TNpLl5K25vZhCcKzfKUcWncGKydzUHyLRRRc/gF/S4woaBzZRrGOok
         lDzA==
X-Gm-Message-State: AOAM530Myv17s2x1iBluKz+yZSkps3rVuv9auDzvdC6yoguPejDFZdP4
        cbTnCWcWC4LcgB9ncR2+B+MDknYGUQ==
X-Google-Smtp-Source: ABdhPJyKmMvz5tETJDN8m3w+kJa1l1KyRMLfQKzogw5UCwNkDU0Vt8cV+4+QEgGIcIIhLU8wM70Beg==
X-Received: by 2002:a9d:65d7:: with SMTP id z23mr9187509oth.131.1610731588289;
        Fri, 15 Jan 2021 09:26:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y35sm1917042otb.5.2021.01.15.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:26:27 -0800 (PST)
Received: (nullmailer pid 1489827 invoked by uid 1000);
        Fri, 15 Jan 2021 17:26:25 -0000
Date:   Fri, 15 Jan 2021 11:26:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH] of: base: improve error msg in of_phandle_iterator_next()
Message-ID: <20210115172625.GA1489415@robh.at.kernel.org>
References: <20210114101127.16580-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114101127.16580-1-info@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 11:11:27 +0100, Enrico Weigelt, metux IT consult wrote:
> Also print out the phandle ID on error message, as a debug aid.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/of/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
