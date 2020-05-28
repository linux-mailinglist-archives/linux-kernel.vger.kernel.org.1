Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08E1E6D00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407451AbgE1U7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:59:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38495 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407396AbgE1U7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:59:41 -0400
Received: by mail-il1-f193.google.com with SMTP id q18so355067ilm.5;
        Thu, 28 May 2020 13:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HEXTfzPxkJii85U9NQnqeGblmqEGIppOJ1PmKJbxo5E=;
        b=hLmeF6rQC2rY36c7AbNaDg81JDB0jW//Y8jkMREmTFzuyE/ypA5kp3YhzBiLzIrr8a
         36MZckWfAQCq0c3DsxHY4fienxMAA/PH9tsa+6lYi53mVCzkQv2QtCMncRlcHrD6xO5W
         54AB0cWekT88aT4skjQCHs0/E0SZ/eUXtdjqT/uvXUR3HFa9rTgpbR6R6A3CmoFSG1st
         kzP3jCgGp14KeaNG0kWPTPE/k3WonRclMvqZo6mecii6QOh2QgXmfcp8IyJxFTgoeexE
         94NIFeAR9U0QN3V4n8iHuwAgk4zUB3C26WmipPHac9MSH0B5fmsZIsgNqmwaomOtzydI
         Kzrw==
X-Gm-Message-State: AOAM533KwkKlv7te2orXyFjhxX8i3p8aondaOV9RHNKHjO1Refjx4e9c
        hqfwTW8Rl0OtFuyS1NpyTHIusZc=
X-Google-Smtp-Source: ABdhPJxONQFv7BqR15FO9E7bLkEzR41PdMboUEIHZSxeHOilpSRvD4fIiG1Wt7pM/kL6XSBPHrD5gw==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr4675328ilm.49.1590699580086;
        Thu, 28 May 2020 13:59:40 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n22sm2978296ioh.46.2020.05.28.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:59:39 -0700 (PDT)
Received: (nullmailer pid 665729 invoked by uid 1000);
        Thu, 28 May 2020 20:59:38 -0000
Date:   Thu, 28 May 2020 14:59:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     daniel.lezcano@linaro.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        ping.bai@nxp.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        Linux-imx@nxp.com, aisheng.dong@nxp.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/3] dt-bindings: timer: Convert i.MX TPM to
 json-schema
Message-ID: <20200528205938.GA665682@bogus>
References: <1589860547-3207-1-git-send-email-Anson.Huang@nxp.com>
 <1589860547-3207-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589860547-3207-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 11:55:46 +0800, Anson Huang wrote:
> Convert the i.MX TPM binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V1:
> 	- remove unnecessary maxItems for clocks/clock-names.
> ---
>  .../devicetree/bindings/timer/nxp,tpm-timer.txt    | 28 ----------
>  .../devicetree/bindings/timer/nxp,tpm-timer.yaml   | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
> 

Applied, thanks!
