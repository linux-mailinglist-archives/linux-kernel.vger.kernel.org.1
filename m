Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E302718E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 03:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgIUBEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 21:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIUBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:04:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1BC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:04:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o5so13357848qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=J+72f74yklzbZwXPP/c2OtPvu+CoHTqGx/+ZolI+Gk0=;
        b=ckVyyTJGF5Y1Z9fAoreEpqyMMBkWSp8ECLjz5+k8BiG6S7sUhA69mU8DKBqfiF/3o7
         jSpiDd2KpXc7mx8l7OOoJujsiimng5p/XM/lDBhkiJoVLu3QqVi1QKshKoRZLOUiXpcO
         rwII/IHwLMt1SIAEyNPkxZiIC3Zk+0K+X7hWOgh5/J1zoI0WISU+2dVID3EnVSiqhNiN
         20oLhKp2mVlrFNY/wjSOerVdypv0yPEfVbRnIRw7RfD0Um+WqBLnakDqHehcO7oo5MZc
         EvzVKvxYqU3XGhtidt6sCS9L7XhZUJbbbPxY7xa+toBwvlj25kOMLLLjs/eEyZnX0UQs
         CtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=J+72f74yklzbZwXPP/c2OtPvu+CoHTqGx/+ZolI+Gk0=;
        b=qsQYhJmSzKcyzr1QlNJEb7ZpDCJVhvqvv4sMRgyItt3wHjdtD3xsclILpgGKcU7hMe
         AY38mxwU6dE17Gm6zXF3l52710kDS0kZxf4uua3vOJH+XPb5QfJD7l9uBaehk2KcFDFg
         DbkBszUC20xaVF2iZh8OtFfT4SWhBHwpr5/NtifWPsMJFxqlEIMCP2AZNYQmwAHzJPQV
         crSrDrm/mc85/+NzmH/Kpd+dXJTc/PnHScZ9kamuYmrO+uWlYd1T7HpP6UJDxY8dzF/H
         jHOTzlyuO2kR+6MMyPhNRsiX0u4tSOhxiMQlMijcCAGN7u6F+XD7+7T9VpKqA/GKpWtG
         bv6A==
X-Gm-Message-State: AOAM530pvMPXw1n61EmSZ83+0AKe5ryLWkBFQ9IvQMiH6G8gGrcvu/hd
        nU6ot+7SRmyAoGDRLBmO6FE=
X-Google-Smtp-Source: ABdhPJy31XmM6/H23APRyy8cX0tcIFePSKgZW4BT9H+DBkWaNJ5upMkwt2Gm2IG9smvD3WpFT+yLig==
X-Received: by 2002:a37:64d4:: with SMTP id y203mr42807562qkb.359.1600650241614;
        Sun, 20 Sep 2020 18:04:01 -0700 (PDT)
Received: from arch-chirva.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id v30sm8744438qtj.52.2020.09.20.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:04:00 -0700 (PDT)
Date:   Sun, 20 Sep 2020 21:03:59 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Cc:     kernel list <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 5.9.0-rc6 fails to =?utf-8?Q?comp?=
 =?utf-8?Q?ile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported=E2=80=99'?=
Message-ID: <20200921010359.GO3027113@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to compile for an x86_64 machine (Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz). The config file I am currently using is at

https://termbin.com/xin7

The build for 5.9.0-rc6 fails with the following errors:

--- cut here ---

drivers/dax/super.c:325:6: error: redefinition of ‘dax_supported’
  325 | bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
      |      ^~~~~~~~~~~~~
In file included from drivers/dax/super.c:16:
./include/linux/dax.h:162:20: note: previous definition of ‘dax_supported’ was here
  162 | static inline bool dax_supported(struct dax_device *dax_dev,
      |                    ^~~~~~~~~~~~~
  CC      lib/memregion.o
  CC [M]  drivers/gpu/drm/drm_gem_vram_helper.o
make[2]: *** [scripts/Makefile.build:283: drivers/dax/super.o] Error 1
make[1]: *** [scripts/Makefile.build:500: drivers/dax] Error 2
make[1]: *** Waiting for unfinished jobs....

--- end ---

That's earlier on, and then later, at the end of the (failed) build:

make: *** [Makefile:1784: drivers] Error 2

The full build log is at

https://termbin.com/ihxj

but I do not see anything else amiss. 5.9.0-rc5 built fine last week.
