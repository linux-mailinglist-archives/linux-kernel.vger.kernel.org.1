Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2D28FC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 02:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbgJPA1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 20:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbgJPA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 20:27:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45823C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:27:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w21so306329plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/hEB6AKTrLHdK9VCat74qeBSs3TgFHVb6aLs93uMg+M=;
        b=lZBiXOd9ZU3TN9yPKu5/2gCaKZIMtxbp7rdUqKazjtWnkzPwwcAzXh7sU8rkLSyOyb
         FhFRvJzeakinNytd2mXOrqa7/tIeVV3iGuVTfJe1txB155bmS3PFysJ7388wOE0m8mlu
         /AjXt4Pq7IEsBl3/a0+ObKeKV4cKyRDY0929IUrg4NU23Q8VA8cyJHz2EXCww6m6TLoS
         L/ZGtSo1HUzS3RM04wVik1AcZSiU8CmnbVwTT0Zg12V7lrejRY49s7DGVEOaIh1T+4cc
         AR2Dr5L5Qzc+En74Ik+gVPAnvOIgZ66Lf65KDj90G+qH3LsQ28E6J2BTWaA5sS4SK/Z1
         k4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hEB6AKTrLHdK9VCat74qeBSs3TgFHVb6aLs93uMg+M=;
        b=kLbKIM40ySZwHntrnoiQn/c9OObTG3TMGiAzSvjNIrVnqMwx/KREOSGmjdyX1YQ1Y3
         c1fMP3cOKFX4+83ZNPXneWwked73a5bGwjlQ3hKfiCQ1zRAXYrNvVbqdr8vEdwkVaOEM
         /Iz62joAB0ULr7IwI1K9S3prfQMKTNmgVRplwq5byhznazs4O+QrlKVWA8L7fwcH8weW
         R+cEDWer80nGd5uXpt8SsC0STan2TLZ4quJKEmJ7OCDdR1tdu7zQTYuqP1V4Hrl0BM/T
         JFmizt6FtUFenxYTRO06VAo5dm5aZBJ2p9sJFz7Ws8lEUvtzX0HLP1C3utwGDeUceZgc
         g8OQ==
X-Gm-Message-State: AOAM533E+la4s7gVnKOy7/lY1o+Zg+QBzqZ8ajEKarFF75xrWKfpyIZC
        GOSnIOqzxV3iGLTcsURX4t8=
X-Google-Smtp-Source: ABdhPJye9yY25EVwTiKCPRnKFGmd3Z/q9mf0Zrg0rzL0Zn6jGzNILCRPKINQmgR9MatjH4VTMfz2DQ==
X-Received: by 2002:a17:90b:1186:: with SMTP id gk6mr1273628pjb.109.1602808042899;
        Thu, 15 Oct 2020 17:27:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id d2sm530558pjx.4.2020.10.15.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 17:27:22 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:27:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: Rework the list_add code in insert_zspage()
Message-ID: <20201016002720.GB2412725@google.com>
References: <20201015130107.65195-1-linmiaohe@huawei.com>
 <20201015185120.GB181691@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015185120.GB181691@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/15 11:51), Minchan Kim wrote:
> On Thu, Oct 15, 2020 at 09:01:07AM -0400, Miaohe Lin wrote:
> > Rework the list_add code to make it more readable and simplicity.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
