Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F922E23DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgLXDAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgLXDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:00:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF8C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:59:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so451951pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3274995OIrIodYLZAPXVphdO1nymbyMxfaEx20SaZ6w=;
        b=gifmByTYbZN/rFI3tzj68H9m91uBP0jKQ2MF3LyG9P6gD/Uf3yh63hkjv4NpX5XWV8
         BnFSn2bCpwG+4x1StJeKR+KqX90+2KF8/lpHRYIwcilVPTdRRoe2IZrRdZg5+k6VOgKJ
         2ZPuJyz0Pzro7uRE/DkqVcYz8mqlzvcB15laSgiMVLpT7PMoyAlzEqCJeEMJmeR9JF0D
         FXPVsiAgKUHOWYEPUs5Wdq4PoW+jaP8x7m8DV4v1Goxa8kfhEC4xTFjq0O9ADx9Lh5AS
         fRxH3SWdiZ9IWK6qJzepU4QPl+arxCsJCvYTIjX1j9Su6hVmgvZTLcyBoGXCMitnIBXi
         ATGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3274995OIrIodYLZAPXVphdO1nymbyMxfaEx20SaZ6w=;
        b=VHrdxAN2uqRQX+896diyjROCfA1CdZXHr472+QgP0UxV6hTCeDT6EURK/cw71xzLaq
         eqoUgzLRRgepbp4BcqbOg7HxIcXARmSoD26cijTvo6hMhKH2d4G+kRqZFb7gFem/CreM
         jARkQwlrz4TK2qUtgmlhKczEjaIeYJML7b7xx9FrMjaUNQGRWrs5BEHGHAgrmxyUZBoz
         hS3MrV+fDroNUBfwqagYUtNLnc4PkVHga25GZWbbyyAgvgLDC7WjiVbvLSYCeMhozAzZ
         3cbwpmzMwoCGSVikVTF9dQ/+YISLwJD4/rR6UqXeEQu/PpW925hB0S1YWCwPb19opkvB
         7blg==
X-Gm-Message-State: AOAM533YaGQPwva7kcK3t4XYyj0YStn99vAeZ864o5wJi9Db9bBZBE3L
        B9lgw+4KqvYvvfRDeV8ErLH5Rg==
X-Google-Smtp-Source: ABdhPJxwB4tNgytYCMMsgD4gR55Q+C/CjqGPeEkValNyYJrOZvu+lWvom1FTWhdXPxOoRUiAYJDLYA==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr2335613pjb.63.1608778775082;
        Wed, 23 Dec 2020 18:59:35 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t22sm24996732pgm.18.2020.12.23.18.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 18:59:34 -0800 (PST)
Date:   Wed, 23 Dec 2020 18:59:34 -0800 (PST)
X-Google-Original-Date: Wed, 23 Dec 2020 18:59:32 PST (-0800)
Subject:     Re: [PATCH] clocksource: clint: Avoid remove __iomem in get_cycles_hi()
In-Reply-To: <20201223082330.GA24581@infradead.org>
CC:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        lkp@intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-b2cf0325-66e1-4e3c-bfbb-b393963fbb3f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 00:23:30 PST (-0800), Christoph Hellwig wrote:
> On Mon, Dec 21, 2020 at 09:32:30PM -0800, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> This cast loses the __iomem qualifier from clint_timer_val, which
>> triggers an sparse warning.
>
> I'm not a native speaker, but the subject line sounds strange to me.
> Shouldn't this be:
>
> 	"don't cast away the __iommu annotation"
>
> or something similar?

The title is also nonsense, I was probably trying to do two things at once when
I wrote this.  I'll send another one.

> Also this adds an overly long line.  Otherwise it looks fine.

Aren't we OK with lines longer than 80 characters now?  Or was that some other
project?  checkpatch doesn't complain, which I guess is why I didn't notice, so
hopefully that means I'm not crazy (though I guess the commit message and title
don't provide the best argument there... ;)).
