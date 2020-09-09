Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20372263450
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgIIRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:18:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41314 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgIIRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:18:44 -0400
Received: by mail-il1-f194.google.com with SMTP id w8so3058415ilj.8;
        Wed, 09 Sep 2020 10:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hr4fQWVMQoos6KFmQBQi97levSHBi+dO9Jnfm/kgyc=;
        b=QgVDrQv79/bMsspyf26g4QQ7M+nDYYC/uCyuQAI6TQmqQO9jt5pBIr+Mlusq9nduAE
         eyKUQSv+CBNtLnXmfaF4UVbv+Eh9R3p20rQfmcfxvpnJx0bheNnCp274h8xntUrA6YTL
         pEbbgtFSY1NAQdGEfXBxhlFRZKPfY3yctAMGgEqu3fy4klGIQ3GZBMhu/ML2mfsl91O5
         m671D9XSpw/34bNwhjwmj+4TwKoVzBKXYDXyqnV6dD5r6WbpGJzHbw5iNhCkiEtNYzVA
         sOWvIiDr89TV/HICs1wPOonQaP+eqy4+Gi9Hn1ym5+2hPL173KUd8Kq+MG8OZQ0TJvEg
         QZbg==
X-Gm-Message-State: AOAM533E7xhtu7K5XJRV2KAI8tOtdLjd6y5OssahsAiIoLgHK5bQASKW
        xYFJZcSYgX4SjyrA1Szz5pt2u8/klmWD
X-Google-Smtp-Source: ABdhPJweONXjnuZtBkOGVqg1AFS1ASeGmxxVhyJmF8gPg8PMO09CmvmPl5R9xygei/39Fl6Prjb6gg==
X-Received: by 2002:a92:bb94:: with SMTP id x20mr4613847ilk.86.1599671923668;
        Wed, 09 Sep 2020 10:18:43 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s15sm1610420ilt.62.2020.09.09.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:18:43 -0700 (PDT)
Received: (nullmailer pid 2680839 invoked by uid 1000);
        Wed, 09 Sep 2020 17:18:42 -0000
Date:   Wed, 9 Sep 2020 11:18:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: regulator: Convert mp886x to json-schema
Message-ID: <20200909171842.GA2680789@bogus>
References: <20200827150640.267f6edc@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827150640.267f6edc@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 15:06:40 +0800, Jisheng Zhang wrote:
> Convert the mp886x binding to DT schema format using json-schema.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../devicetree/bindings/regulator/mp886x.txt  | 31 ----------
>  .../bindings/regulator/mps,mp886x.yaml        | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
