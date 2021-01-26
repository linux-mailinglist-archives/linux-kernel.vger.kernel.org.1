Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2722303A96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbhAZKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbhAZCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:04:57 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D9C0611C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:53:36 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g19so551070qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BcKx8yKk9DEzeYQ1umTI+yLBl6nPj9ta1OpCtTjEqbQ=;
        b=njnDopwPY7IHJTT3bdBrU9QfFha4FxpxvTw/x0eCbFDHDRkNCsMhN+UQ8bqUqh+nhI
         arbXAHIod5UjilnecY3GMdwiG9CkFv/AoitTOC0pGdAMapHEH+1EXa9PS06XyY+iwklW
         3xZR+MdCR4jnI8L57SQhpX2x5w6gqYroe06iSaPQuj6Zv7YSMlxhKJZeq0b+wgBw3kT9
         8MqiisibVyyyv7yJkXZhmWOE8+Fa6EyKnp+86TU1Hfw+W+QNIEe6Jds13qc0wx6tx/KX
         GJzaD5UUS1yjmPg5fEPwLQ4S2gjz2NUKBaHgQTfYwffboht2+lJqDU4R62maGsAvJbRp
         OVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BcKx8yKk9DEzeYQ1umTI+yLBl6nPj9ta1OpCtTjEqbQ=;
        b=bCudxR8pMZLAobyNnx+s/P3hh4hHLHWD0sjA3AXZN3qiUF1qA8PzVVEFU0xltdfyUx
         BUK9HrmPdx1hX1L6UJB+HHx87/a7yl7j48q9W19LS+WCyKd3LUAkoMI21d7mHLtVdmA4
         HhqIw9sj0MLMLpSN+Ht5DPmxmUixFF94AJt+LCCISAgD7kVp4B57hOb0giy+UN3a548y
         8hNFn/KFWwgl3oGSf3T+UHKA7J7eKfChg86Qzq2k6Qdrh3jj8ARKFKfv5Hu7CtXiUKrL
         MiafB+LxocSxLA6lsByw6ngdVjI9hIZnVfxeWfmhI2ANDVGqYkQdW/tkihJR2Tq0pyWp
         nnPg==
X-Gm-Message-State: AOAM530kbCz+pIIeFEfkBBPe2rdCBvJ2MOOCLQ0T6wKqsezdQpFharIu
        f388GiDV9p0EVFtbWmfaG70=
X-Google-Smtp-Source: ABdhPJzNSrqw8AGfWL6w4wY3IRVZzKaALDklw4GZn0asaDzWVB/jdpCgw+2C2dmFj2yeGLIXJSZj+w==
X-Received: by 2002:a37:a909:: with SMTP id s9mr3577509qke.489.1611622415327;
        Mon, 25 Jan 2021 16:53:35 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id i18sm13174644qkg.66.2021.01.25.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 16:53:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Jan 2021 19:53:35 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Saravanan D <saravanand@outlook.com>, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] x86/mm: Tracking linear mapping split events since boot
Message-ID: <YA9oD2djENLo4975@slm.duckdns.org>
References: <BYAPR01MB40856478D5BE74CB6A7D5578CFBD9@BYAPR01MB4085.prod.exchangelabs.com>
 <30752f8e-16e9-d093-e6ec-31fd45715e9d@intel.com>
 <YA8q3eSTuIrUmPeM@slm.duckdns.org>
 <0d402da9-d7a2-a3b4-eb6f-bd1b768b3a85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d402da9-d7a2-a3b4-eb6f-bd1b768b3a85@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dave.

On Mon, Jan 25, 2021 at 04:47:42PM -0800, Dave Hansen wrote:
> The patch here does not actually separate out pre-boot from post-boot,
> so it's pretty hard to tell if the splits came from something like
> tracing which is totally unnecessary or they were the result of
> something at boot that we can't do anything about.

Ah, right, didn't know they also included splits during boot. It'd be a lot
more useful if they were counting post-boot splits.

> This would be a lot more useful if you could reset the counters.  Then
> just reset them from userspace at boot.  Adding read-write debugfs
> exports for these should be pretty trivial.

While this would work for hands-on cases, I'm a bit worried that this might
be more challenging to gain confidence in large production environments.

Thanks.

-- 
tejun
