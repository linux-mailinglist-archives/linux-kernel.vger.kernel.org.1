Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356332FA5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406402AbhARQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390840AbhARQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:00:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:59:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so10084207pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAO4XVga4Bz+KODODRuxwsHbnVzruwUFdi/GoUQHg8w=;
        b=fim6oswJW+6O9lZtkbJ3cAgrAmx+v+fjNJSbpYvYbDk0wnTLWptVuV6V1SgoqKnhky
         HJS2gRuWFbklP6EC5a7AKKkM5farhWhaFeRihLra5icodH4lHSA5CKITfVJ9f3fwBTYB
         HNRMDMfVvrJzCdWOelw/RNI+PbU/aKnNPs+4EQ+AuUxhIKPbhto4HAvFbIJ1IcotqsEA
         GwJoJAfbAK82OLKpj10TbDDDrM0EVGMHpL9Y8WkVBenZTD2jA2duLctBD6a5i+srg04N
         X7jkBgtWdFRLSmaqAc/U8jsxVypHf2dHn1i/QjV7GGaR9DdVghdIZatBHVua1AJKh+R1
         wPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAO4XVga4Bz+KODODRuxwsHbnVzruwUFdi/GoUQHg8w=;
        b=C2HSp67+bR1D0n/NKgHmKzskqhffrPHPuIRwjLHQaZcGb3PlwU9OMR4SffgPBYk0T6
         eaj14Ed8h3s23dQQtFs3Qx+gq4jbemRSZckcc6sHApnkFHdugiA9JPQljlIPeTBh9BGy
         MbcklISOL9yYyyVnBSw33A4OYPP0seDxv/iVCqcFMh8kAdAd043ooIiz2cpzbzF8cm/c
         L/SQqWMPdLwixjZk4K8C8o3EFKoPJjodPVHKxhGUnrjN7HpXucuLfFauURv8R9GM1ndN
         7igzrQI4HT33TpsKgzrtBP58Pntk6bLrf4z9p3V4VWwkWF8CvdgjBnkF9T3OcZmB3OB4
         dpaQ==
X-Gm-Message-State: AOAM530hSbbVe6upF1qpDWZJDv4KOqwHY1mE1FvTkX14UnHCFOZGMIGz
        M8a/SGmubuDCIxL2ZFiCYQamEQ==
X-Google-Smtp-Source: ABdhPJyfk4Aah6jYIgWPK1hlcBoMOMjjqeFEdeyeGdyyCb7mCaIOz9y0pIHqeS+No3RB1UuSmkyCtg==
X-Received: by 2002:a17:90a:9302:: with SMTP id p2mr9597454pjo.213.1610985564339;
        Mon, 18 Jan 2021 07:59:24 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mj21sm8442604pjb.12.2021.01.18.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:59:23 -0800 (PST)
Date:   Mon, 18 Jan 2021 08:59:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linaro-toolchain@lists.linaro.org
Subject: Re: Compilation issue with Linaro ARM toolchain
Message-ID: <20210118155921.GA462671@xps15>
References: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the Linaro toolchain group mailing list.

On Mon, Jan 18, 2021 at 05:49:39PM +0300, Sergey Suloev wrote:
> Hi, guys,
> 
> I am having an issue builduing kernel 5.11 (rc4) with Linaro ARM toolchain.
> The issue seems to be related to CC plugins sources.
> Here is my build log: https://pastebin.com/DTn7Szax. I have never seen this
> before with versions 5.10 and below.
> 
> Thank you,
> Sergey
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
