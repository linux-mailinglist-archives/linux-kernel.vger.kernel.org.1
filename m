Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18027EE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgI3P5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3P5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:57:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953DC061755;
        Wed, 30 Sep 2020 08:57:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p15so1134150qvk.5;
        Wed, 30 Sep 2020 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxcDnFkM12RjQdmqBTOpljbeUrELtp9vvZfj8rq32tM=;
        b=hASQXTOMn064a1WetUtXRjnhaI2+e6zWriulG2iO0sy/35zAsvf5xsQRw0srPf/JsW
         tHPzOxjdmDfcZaGxY+GJ+sjMnUlSHvDFWBa7vV0u9ODmuKvsSrzhaWkAHiw8i6UkYH3P
         +jbZYEYJ4tSGZH3fx28mvpkSfVwdgl5mGnVvwshrsCIbqR1DB8g/PLrSHIpDv+eXCgyZ
         KUmTdubE9InzTWfeGGk//saJ/O9uT6EX0V5Whdz4qa3dR6mi0BreGfSHpFIudrGn8TiT
         ZTdmlitV2hj51UBDW//zv60xNv1nsbxiWrQ7gHrp0wZELe0E9lpX6xyMRWGNtOadYORX
         D0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XxcDnFkM12RjQdmqBTOpljbeUrELtp9vvZfj8rq32tM=;
        b=FXxkhp/dirlVQjN1oZPOOYxvSVBnYgTgDS4keVdG4qnpppGu2V6U0r6/I2jdaB82Gk
         KRd71FTnh00gu5dyDSxmSPreTC+s3ZT9bvNqucb3Q8ar/lSqVa31SGZpt58sd/ld6hGS
         9XsfW0j/hr/wwiVDCxE4xceVohN+yLGfuWCaL9QPU599Kg0+GC6sC9mf+tDV9zysNzBw
         7uSdy7yv/NRXbnbfWoCiVe574IRfssxM4cafZVcsOzlqtt8v5QdFP74H6nVZgJbhzkPR
         EVcM9011kPov19sK9I3BMZ/k2hW3O04ty/RyWrmGSvzBF++POYBwhUFp7ZDvl3cCdq+Z
         76kg==
X-Gm-Message-State: AOAM530IbwIltzqEqxCGls0MJeXRMC0/DwWZZiC7pblCibvpoXJaLifr
        l3gffASPOagasf/UeoDUlFE=
X-Google-Smtp-Source: ABdhPJzg4a+tqrLjy8JKUXgO06dZZjKIwVdLjHU5Qg3sw4AcBcoffkOMXIEcGLD+0nPRiZ4KgqrGQw==
X-Received: by 2002:a0c:8091:: with SMTP id 17mr3097080qvb.19.1601481434987;
        Wed, 30 Sep 2020 08:57:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id t43sm2880747qtc.54.2020.09.30.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:57:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 11:57:13 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 49/52] workqueue: fix a kernel-doc warning
Message-ID: <20200930155713.GB4441@mtj.duckdns.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <1d025719a6f6a55fcb5f8a9c382ed846cec9a4d9.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d025719a6f6a55fcb5f8a9c382ed846cec9a4d9.1601467849.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:25:12PM +0200, Mauro Carvalho Chehab wrote:
> As warned by Sphinx:
> 
> 	./Documentation/core-api/workqueue:400: ./kernel/workqueue.c:1218: WARNING: Unexpected indentation.
> 
> the return code table is currently not recognized, as it lacks
> markups.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please route however you see fit.

Thanks.

-- 
tejun
