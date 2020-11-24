Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C492C291E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbgKXOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbgKXOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C889C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:14:10 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s18so22759523oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hz2P2WPL1KrEPUlVDM13R5/lRmiVmQvTmZ2t096gK7I=;
        b=BuHOigF/7Vdcojt/ZD/BdAjNsubYUWz1psl6JtgnuMzs+Pp3SNjgx7E+ANSgpkyJYC
         PO+5vvizSnDU0R+DMz5TSdxewBHKMxGVsipqgrML2jiNbgSaa00KjZbzCTNmo5RJ77hi
         iSzOilufJSPMP9cODFm48MGiVamh9X0VKcl5dAMyMShyxyeHQ8Qv3JIx2ea76CzGZpRU
         ijM8nRUp2vNiF7mHHBS//oT4wY4fvv505qVrQNTA8zjlI0i3ZKmT1YsEbdVwiDKJflwb
         4tr4hbNZKJAiTyfU9e+zS0jgOweMp3wOdTEp+dI9GDsig+q1zHpQMVEpv/CYhTxHRuwS
         EU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hz2P2WPL1KrEPUlVDM13R5/lRmiVmQvTmZ2t096gK7I=;
        b=f5Dnu+kVKKkaaotzp3iWQ7h+WJ4YzJGxvPhar4WxyXDpXtOxfOtyvhPLjPSL/H2eYh
         Q01YQ9zmd0hzD1bXSmIYH203jRP3+fbDlIl05+mhYX3/3bkA+OsnR+TiyQohm3okFQMR
         uny5d8hUMbqUZBUVGkA32mEFioWwJBd5jKnf5EZYmIpDNhG2aHp1vyCj8ua5PwsAdd1f
         qvdSdSgOwDVIJAQPgXjR6CpodPxwPkS4bIOYemuNTbDFGmjfIo3qcglI5Y5DH62Eeibl
         FYH2vvjDcvvVqCZuJU7md8sgZdwp9AO/gWXTU2Va38L+4zwOpuG4aQhyI1hTImCrRgms
         40mg==
X-Gm-Message-State: AOAM531r8B1+eH291Tt6tC8y3FYnLNkVoqI6xFgpoJt15Xo1tGBZKhOE
        9Thw53cIFJ3FC9QdqezucMZ6GQ==
X-Google-Smtp-Source: ABdhPJy8NCNmgnxEIPdXXoQnpW4iEmbZkWduC2RmKNv+z7ymjReFm++owUrGvbEvIHTXNQd9ydO5oQ==
X-Received: by 2002:aca:3205:: with SMTP id y5mr2907934oiy.162.1606227249741;
        Tue, 24 Nov 2020 06:14:09 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u63sm9283170oia.50.2020.11.24.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:14:09 -0800 (PST)
Date:   Tue, 24 Nov 2020 08:14:07 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20201124141407.GA185852@builder.lan>
References: <20201124181938.11046212@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124181938.11046212@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Nov 01:19 CST 2020, Stephen Rothwell wrote:

> Hi all,
> 
> Commit
> 
>   872b41c9a255 ("arm64: dts: qcom: sort sm8150 usb_2 node")
> 
> is missing a Signed-off-by from its author.
> 

Thanks for spotting this Stephen! The mistake has been corrected.

Regards,
Bjorn
