Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487662C7105
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391118AbgK1VwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbgK1S52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5CC02B8E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:43:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b23so3723688pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BA6eIMkm9MQ4GTAVJrwtWOn+ULKRX86lln/0fo5tdB8=;
        b=iCjV3xRN8G8M0lAA3Nf7UZ6p+W+MXYNiuaRfBAeA1khCH/RoUQCa1+W73y5B8j0Ehh
         uS9xwrse7seGnrTgmihvfXKJTaPfknjaZPBNIrYEKBvXauTYcYKu9yyFJMF9se9egr0t
         rxi8Lb4/2gW89NRU7r3KzBOFrM/gDRfP5tQxA6qIuLEQHJ3j6RTJRGynTUjRkF4Ru3Kt
         Qz22XmECua7fHgtfvS1P+nNtZIk08B1jze0CvkNhzgNa3KnWyN1cTbsCc5K5UZ3ZTiMG
         t7O/RiDO3uIGDTpKKQUyDHDoDCwrKt5geR9tKxSBpM8iIo1Kq6ugQBall6GgzEaTXZlr
         TysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BA6eIMkm9MQ4GTAVJrwtWOn+ULKRX86lln/0fo5tdB8=;
        b=p1KeJETF4gQu5ZQYGXMHsVE0y2wq9lOHhnyq19mYUalab8XXHv9Dp1QETFNOdtFNxB
         8Rm9iy5YpEckMuQUChm/DlUsLBoUQhcQkvZh2boGx/Q/kVWWBapbeSeDn9Y8Pn+YtQAn
         Hj6HM1rlxJqfuzTIylaOw5p3Pvn6C+4D4AgoRvfDizS3kSGfgIFGhIQcHqnS8hIjvzJD
         E+kHAHakr6vfMYx7szFXrJ39a1iR6os1ISJBPcCFc5bSxfkEJM2EnVpQOXSUMtcqd0dh
         yPvk7h5LCjS5G/SeADF4RfOPQH7WwYA8yjUybQjDgqsiPwcuxDl8CoFvF1WMNkCjwDf8
         gx9Q==
X-Gm-Message-State: AOAM531zPUc0xt3A9cn+TeeAxrb7DnERMes1uhulwkd64N3wqhEdgsTx
        7TuhthSS2RwHgPwkkJU8R+ev
X-Google-Smtp-Source: ABdhPJxBZ930/XEYxxp6E6/sKW+/GdIRK3+zgPDQf83pitm2fXz7YjvQlhypmi0/vcOQeLM5xzMB+A==
X-Received: by 2002:a17:902:7e0d:b029:d9:ec82:2d24 with SMTP id b13-20020a1709027e0db02900d9ec822d24mr10693242plm.81.1606549437282;
        Fri, 27 Nov 2020 23:43:57 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id a16sm9975350pfl.125.2020.11.27.23.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:43:56 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:13:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
Message-ID: <20201128074350.GE3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
> Add the linux-actions mailing list for the Actions Semi architecture.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

There was a patch from me for this change but I don't mind taking yours
as long as we keep the list updated :)

I have just one comment below, with that fixed:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a85c1881cf07..8428aba52581 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
>  M:	Andreas Färber <afaerber@suse.de>
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

No need to keep the generic list, please remove.

Thanks,
Mani

> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/actions.yaml
>  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> -- 
> 2.29.2
> 
