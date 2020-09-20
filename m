Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E42715E3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgITQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:22:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33586 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgITQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:22:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id g4so10618254edk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1bq14EGxIyNQfdTfa9z5KxrDJcbyJ86EIV1lRNICzo=;
        b=U5OrKzWaLYVlumtd4QkClKjxXOhF9BVqzAc0KbEYdwmgyrwrSAYYRA+9iYkwTNZSE0
         eAbmuKygVTNhBlfPRZ1uowahlbsf8KVb4DLFf1w0sJjIPznzGOeOvgrKJUIEH8yra0kj
         +BqIezL9A3pUt3DNknbxjCD7Yx0BY6pwXPqOStheRDQ5BJsOJWYCUE6JkPJzDMtVJ6sk
         OVxDh1JHKPz/CMmJ0YmfSn3ZPC2/96FItd3bt/sMqrv89QBaoR1Te8v4Lf4etgUbV+En
         iFcOXrzViAM/8ER5djJFMXZRm2o9IAcqNYujaFqqnqQD9euO+htRjk9n4RM37Fq81TnG
         /rdg==
X-Gm-Message-State: AOAM531qskw4aGdqF85JxFcFgerZL+wLshJUbJRy9yg5RQKCY+d74GBd
        T1ww6eaxm8cmjDLZFpaSS4mCBF8jV2Y=
X-Google-Smtp-Source: ABdhPJzendPU2zo0l7Z7Afi+TF93pbstS0oX3jnP10T3HPHBya4IRyxOgU387lhpmQNmMdPNVQq7IA==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr48977974edv.74.1600618929081;
        Sun, 20 Sep 2020 09:22:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id k19sm6845314ejz.28.2020.09.20.09.22.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Sep 2020 09:22:07 -0700 (PDT)
Date:   Sun, 20 Sep 2020 18:22:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH v2] add the FPGA Device Feature List (DFL) EMIF support
Message-ID: <20200920162205.GA10210@kozik-lap>
References: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:37:01PM +0800, Xu Yilun wrote:
> The patchsets "Modularization of DFL private feature drivers" & "add dfl 
> bus support to MODULE_DEVICE_TABLE()" are all queued to linux-next. So
> there is no dependency now.

What do you mean there is no dependency? The DFL is required here and it
won't compile without these patches:

  CC      drivers/memory/dfl-emif.o
../drivers/memory/dfl-emif.c:10:10: fatal error: linux/fpga/dfl.h: No such file or directory
 #include <linux/fpga/dfl.h>
          ^~~~~~~~~~~~~~~~~~
compilation terminated.

This simply cannot go in without dependency.

I described in your v1 submission what is needed here:
"Anyway I will need a stable tag with mentioned dependencies or this
will wait for the next cycle."

Best regards,
Krzysztof
