Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB803268C82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgINNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgINNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:45:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FBC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:45:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so17684681edt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P4Vr4Y7phYqh0vokWotddxjtKZaBZJodByw1Suscz0A=;
        b=kh+CVeN9meb1AoxLYMWvaTFPYGifkZuTlSS1+0GGui9jRMcQ532JZE0NIDZ+QpEFVp
         GUfPCEYOcaR95os+/TZk9gwopzKlrzvNngyBuRLeEsHpDjkS2GvWaHPj1PL5VQ6LwdpD
         2cHlkMfsQjw13Fj3KX+BGoEYAcNwWMueEx+qaBzlIy73doysx5bYqC1XOqy+k4B2wDqz
         XwXPjefF/aVv1IoSlJAzXoXV4FJvWgxKTqvnUH3HOWmH1UgHFDdLXOiRBEkmmAvA2J2q
         idk5DDmM89MdT0BAO8NAhpDGeP09C2TOquNfZrZMBFN6KpEmS+u7wz9ZEuIkDONFHzkG
         2mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4Vr4Y7phYqh0vokWotddxjtKZaBZJodByw1Suscz0A=;
        b=NYYYb+jM9f+fjqrdmoVs+9ryxloO0otFWr7k8wxVHYDyTCLnW4PDI0HEiC2QKz87FB
         uKoYeHDj8L3L92zUVwRLoB/YmW/HZXhGSzCL7j7uREczS4wkcygt2U9PAo7huWUei8L4
         5f5nNvCYTSYtSa6pqGsy2zBn1LLIgo41LTV22E1KOQlUgvhiC6FYfRxHh3sLVTGHEAT2
         fDE0aNy5TF2o+uBnFdHtufd9ERSEmaPMwj+lW0Zf8ym500YlAU3xTRi2PYaDVm5faLaI
         sroLLe6C+4+y/UVIR6OQOyQTpp2HtYBMNt0WJBYLL+P9RZ9jE5vu8/khdE0zgMSj/EYz
         E1zA==
X-Gm-Message-State: AOAM531k3ov90VQXup0JRY1wP5av9G1R/exXur4drzBrGbuyUt1jsZmM
        3BQMvvftkVu16Kb24WdTp/+EtQ==
X-Google-Smtp-Source: ABdhPJwrz78ykRk6o2gKTF3aKAzlbbpoL1QIxo40v3Yo2G4fRlFwh/nH8OxStDeU0gzs5eu9YxiRag==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr12982822eds.72.1600091101751;
        Mon, 14 Sep 2020 06:45:01 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a18sm7745507ejy.71.2020.09.14.06.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:45:01 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:45:00 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idosch@idosch.org
Subject: Re: [PATCH net-next RFC v4 04/15] devlink: Add reload actions stats
 to dev get
Message-ID: <20200914134500.GH2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-5-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600063682-17313-5-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Sep 14, 2020 at 08:07:51AM CEST, moshe@mellanox.com wrote:
>Expose devlink reload actions stats to the user through devlink dev
>get command.
>
>Examples:
>$ devlink dev show
>pci/0000:82:00.0:
>  reload_action_stats:
>    driver_reinit 2
>    fw_activate 1
>    driver_reinit_no_reset 0
>    fw_activate_no_reset 0
>pci/0000:82:00.1:
>  reload_action_stats:
>    driver_reinit 1
>    fw_activate 1
>    driver_reinit_no_reset 0
>    fw_activate_no_reset 0

I would rather have something like:
   stats:
     reload_action:
       driver_reinit 1
       fw_activate 1
       driver_reinit_no_reset 0
       fw_activate_no_reset 0

Then we can easily extend and add other stats in the tree.


Also, I wonder if these stats could be somehow merged with Ido's metrics
work:
https://github.com/idosch/linux/commits/submit/devlink_metric_rfc_v1

Ido, would it make sense?


>
>$ devlink dev show -jp
>{
>    "dev": {
>        "pci/0000:82:00.0": {
>            "reload_action_stats": [ {
>                    "driver_reinit": 2
>                },{
>                    "fw_activate": 1
>                },{
>                    "driver_reinit_no_reset": 0
>                },{
>                    "fw_activate_no_reset": 0
>                } ]
>        },
>        "pci/0000:82:00.1": {
>            "reload_action_stats": [ {
>                    "driver_reinit": 1
>                },{
>                    "fw_activate": 1
>                },{
>                    "driver_reinit_no_reset": 0
>                },{
>                    "fw_activate_no_reset": 0
>                } ]
>        }
>    }
>}
>

[..]
