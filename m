Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC92CE3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbgLDAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbgLDAFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:05:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A8C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:04:54 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so2462636pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tl5Utng9ytojtJagiqymkbPGSz2X+7BJN1ECR1XJmdk=;
        b=Wd3/5S5tk2qpeNkG1ZR6yr5Ao/cQdLRr+Xxc+RBPqqRGflpAxei2YGZamgE2qeI1Ql
         IW0+JlMniOfHCDVB11iWFvFOJ35JI3WJtssx0LkGQm+ZKTblndHLIsLrfbKfSycogDcT
         WIfS3K5tDqgohvZlt1qrI4G/ltTwvz6PXfcOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tl5Utng9ytojtJagiqymkbPGSz2X+7BJN1ECR1XJmdk=;
        b=n2feGdjk6A0KuCaZzHIt0vjDR6u92iAhcwwS0fhuedQ+BqQbSP33Ok3LI5nonJSbRV
         OyWH3opWU6REGUm1CMlKuzqBe22nVjXCDTu0GM9alK+MdlAahfbqfY3UK6bfzQM56a16
         Mm0zp8T+6UJCXgkho0rYOG14BhlEcI93wizZGXB9C9V/lSXrM6VNlIHbVHRlJJie5ISx
         e4u2UcIhv0KdU9YA/mBClVAoQCrlQ+uj+A1hyLxPP+LUcUPwBPKMP6QWjXgFIIJcSV7Z
         ftnQxBCXx5D3hlKFLWv4HaS23DoWQP4kUC7dGaRm/JbD2Ykm5ltyHOfETvWSxoa0Rm0M
         V39g==
X-Gm-Message-State: AOAM531ro4nXckxXkB8nP0i5PBnZMPMDbZJJeGuawwaFDvPlx6xPZ6Jv
        JEhG6pgI9kJAtn0OUhShyOnCtzDPcG8iGw==
X-Google-Smtp-Source: ABdhPJwqWAtfUq0a7sJA6kpYXTEPQNtxrnLYrGTjJeUVg2jwAslTLepC7yHks13wUQXND/NxfuaxEg==
X-Received: by 2002:a63:c749:: with SMTP id v9mr5125868pgg.451.1607040294421;
        Thu, 03 Dec 2020 16:04:54 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p7sm2858430pfn.56.2020.12.03.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:04:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201203231232.1482792-1-arnd@kernel.org>
References: <20201203231232.1482792-1-arnd@kernel.org>
Subject: Re: [PATCH] coresight: remove broken __exit annotations
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Date:   Thu, 03 Dec 2020 16:04:52 -0800
Message-ID: <160704029234.1580929.9183785406117157105@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-12-03 15:11:40)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Functions that are annotated __exit are discarded for built-in drivers,
> but the .remove callback in a device driver must still be kept around
> to allow bind/unbind operations.
>=20
> There is now a linker warning for the discarded symbol references:
>=20
> `tmc_remove' referenced in section `.data' of drivers/hwtracing/coresight=
/coresight-tmc-core.o: defined in discarded section `.exit.text' of drivers=
/hwtracing/coresight/coresight-tmc-core.o
> `tpiu_remove' referenced in section `.data' of drivers/hwtracing/coresigh=
t/coresight-tpiu.o: defined in discarded section `.exit.text' of drivers/hw=
tracing/coresight/coresight-tpiu.o
> `etb_remove' referenced in section `.data' of drivers/hwtracing/coresight=
/coresight-etb10.o: defined in discarded section `.exit.text' of drivers/hw=
tracing/coresight/coresight-etb10.o
> `static_funnel_remove' referenced in section `.data' of drivers/hwtracing=
/coresight/coresight-funnel.o: defined in discarded section `.exit.text' of=
 drivers/hwtracing/coresight/coresight-funnel.o
> `dynamic_funnel_remove' referenced in section `.data' of drivers/hwtracin=
g/coresight/coresight-funnel.o: defined in discarded section `.exit.text' o=
f drivers/hwtracing/coresight/coresight-funnel.o
> `static_replicator_remove' referenced in section `.data' of drivers/hwtra=
cing/coresight/coresight-replicator.o: defined in discarded section `.exit.=
text' of drivers/hwtracing/coresight/coresight-replicator.o
> `dynamic_replicator_remove' referenced in section `.data' of drivers/hwtr=
acing/coresight/coresight-replicator.o: defined in discarded section `.exit=
.text' of drivers/hwtracing/coresight/coresight-replicator.o
> `catu_remove' referenced in section `.data' of drivers/hwtracing/coresigh=
t/coresight-catu.o: defined in discarded section `.exit.text' of drivers/hw=
tracing/coresight/coresight-catu.o
>=20
> Remove all those annotations.
>=20
> Fixes: 8b0cf82677d1 ("coresight: stm: Allow to build coresight-stm as a m=
odule")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
