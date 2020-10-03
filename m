Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85E428222A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJCHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJCHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 03:52:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DEC0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 00:52:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so4166486wrm.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7b7Gm9jxzg7/k3OZeLp9T9xKAcOx+CD91zN9b3U6CB4=;
        b=PH4NFabJpRVajcxyjtThedVQYiDclN+WKeUsmxxmKRED2sf6gzJ5mJ2VhLF7t3rjVj
         Kua80HVueLGbIC56hvSsEByZ445UjIa0vewZcrXQGpqJWINl6IrCZNvOln28SVt3Hw+v
         iPYljGST7OdI3oph9Pmx9BSqpnuouji5ibYOIHhZFbfE27yOgILZwlElObZsJjHhJbKY
         UZ+bPMSwc/f4Zohakl1+aonlNKkOMTVw3y3EY2pjOQ082HYN0ZuixvkaKcFg7MCuyTe/
         knqMy9LfRWHPWGT1wCd9hDO1ihjQxft+flBgTYHrHSEyBgUd98RjAuZ8vYZLGC8tCjFj
         g1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7b7Gm9jxzg7/k3OZeLp9T9xKAcOx+CD91zN9b3U6CB4=;
        b=f7ag/mwOUiQoJrWqlTtqmmdJV243qXfxcELFa52/Zts8GxfA3rw75BFbwqln28zlNo
         vCifbLaC8EIxZyv7Cs9LBltfzXytWeuOqNPDQPnd1XsvpOOtKPsDvphV3cPp1j2V5eLa
         qi03Rtht/Q3abASi1j9jNPRhXwic7wzILYJgZvApM+4Fo9TAyKxe+Xa0XZUQJMiYUN1c
         wIeJhxj3DLTbiguPPA1N5vXOG5OIJDXWbbyr+4mB2hlLUR9TVeAtCdb8uT/Y8GuQL+/l
         woQb5H3keeWg3fylvAFweT5RzPsM6BhNQUE/OfJrHsHm6iQNSHQbJMrziPylo97iyuhU
         StRA==
X-Gm-Message-State: AOAM5330+gUy7oFk1ujr3mXNDR9ec0RbZFk+qrLoq5a6t8Ri5OP4BiYW
        oALXeQYhZ+/H0yeYBM+KYPhOqw==
X-Google-Smtp-Source: ABdhPJzn73gK8q+yLkkC2rxrSwLl2igZF3RwdM0Lx7Y24GyeNHina+gpOQiKspLfTfRQ8XuUZG9Esg==
X-Received: by 2002:adf:e312:: with SMTP id b18mr7468840wrj.372.1601711530662;
        Sat, 03 Oct 2020 00:52:10 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v128sm4250898wme.2.2020.10.03.00.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 00:52:10 -0700 (PDT)
Date:   Sat, 3 Oct 2020 09:52:09 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/16] devlink: Add reload action option to
 devlink reload command
Message-ID: <20201003075209.GD3159@nanopsycho.orion>
References: <1601560759-11030-1-git-send-email-moshe@mellanox.com>
 <1601560759-11030-3-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601560759-11030-3-git-send-email-moshe@mellanox.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 01, 2020 at 03:59:05PM CEST, moshe@mellanox.com wrote:

[...]

>+static int
>+devlink_nl_reload_actions_performed_snd(struct devlink *devlink,
>+					unsigned long actions_performed,
>+					enum devlink_command cmd, struct genl_info *info)
>+{
>+	struct sk_buff *msg;
>+	void *hdr;
>+
>+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>+	if (!msg)
>+		return -ENOMEM;
>+
>+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq, &devlink_nl_family, 0, cmd);
>+	if (!hdr)
>+		goto free_msg;
>+
>+	if (devlink_nl_put_handle(msg, devlink))
>+		goto nla_put_failure;
>+
>+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED, actions_performed,

This should be NLA_BITFIELD, I believe. We use it for other bitfields
too.


>+			      DEVLINK_ATTR_PAD))

[...]
