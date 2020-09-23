Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D05275BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIWPbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:31:44 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38801 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:31:44 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so21274776ilp.5;
        Wed, 23 Sep 2020 08:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDSrM+2qag8Mi4EwVoNpOsLwaDLefgPAQJC2WmjIW7I=;
        b=SMzFz1HsL7UP4a3YHc87u6dTsOFDUhUPDAzksSjHXxlYO71Fm43QFLvYVz+tDLSfRt
         nL+eAn6hgp3XjvEGe2H6HxCwDrG4UOOiX1JQO+hY4Jd3ZdCFc9x2wJR84cVfHboP31gy
         EFtZJb43aFDGeJYGKqdebtgrZojRqVYfpFmoVl6Ja4eTJteeP0VmictQ7uL8A2951NAD
         hlDUHQenr7rMPcWTtyX6o2pNTDYPCL4XjtQBd3OpRp6gwu439OgZ/iQZfS0CpWca2HSx
         eyzhNc1qKx6kNXDA3AM8FJwzvGdXNIEbKR+COY/ht/6gRprNHcgOhIZ8+AjFzI9zXUFl
         9pbA==
X-Gm-Message-State: AOAM531rVeWAcjQMziDV+MipTZb/Pj15IpI/msU0IwyCWWxExEHw3O7h
        e2kSVvVKAyZ9jkI7pJnGaQ==
X-Google-Smtp-Source: ABdhPJz1QJz3OF8yfLjCzFjyh8YoBs8bUNPIO2k5HfL3QPI87a1wP3JWTpbVUu6wghnAtLAQ3wKDSA==
X-Received: by 2002:a92:de48:: with SMTP id e8mr344501ilr.102.1600875103118;
        Wed, 23 Sep 2020 08:31:43 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y7sm10831723ily.58.2020.09.23.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:31:42 -0700 (PDT)
Received: (nullmailer pid 785379 invoked by uid 1000);
        Wed, 23 Sep 2020 15:31:40 -0000
Date:   Wed, 23 Sep 2020 09:31:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V4 1/2] dt-bindings: mailbox : arm, mhu: Convert to
 Json-schema
Message-ID: <20200923153140.GA785345@bogus>
References: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 15:09:17 +0530, Viresh Kumar wrote:
> Convert the DT binding over to Json-schema.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V4:
> - Dual license
> - improved description for interrupts
> 
>  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 87 +++++++++++++++++++
>  .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ---------
>  2 files changed, 87 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
