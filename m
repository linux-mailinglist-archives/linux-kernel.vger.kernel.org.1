Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC812835B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJEMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEMST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:18:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161FC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:18:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so3546728wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9bbkLmqsGFegNG0ldfQK4cwI5yP6xy9ZwsyIxzLr2+k=;
        b=bJXCxENKxN0YjKNjI+Px8XuEUqcna05jHeVL6wlke2M1w0U1mY9dou6HQQycrQ+U4H
         9/h4rl3jHWPMirDiREAV6Uu29gGbqIeZOCbYDl952N4lZqlJnBAKturIM5P7yMGzockf
         8Hn4K/bn2jVcwIYhjV9I4Jk6cbrGmByt65gaWH470kB8ZPR7XydudT+SkeUeMOEIzTQ9
         ynKd4ypjvtP3Eg1eW3u8HZk0MTg4qiOuwo4zDZ+jJ8M9rBi4+mIgyMDPX1vwDtsnEyY5
         MA41Ve2cNZ7psS9U9clPzQPTXRBglPbNxNOgOfrbnFcZoMs04yCW2AsiuVCmupqOKf3R
         WHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9bbkLmqsGFegNG0ldfQK4cwI5yP6xy9ZwsyIxzLr2+k=;
        b=aW7QdVLvtqdgjSRosGwIr+e8O4DQOZY0CMwjL9AFA9c3KYuz6e9hVjofKO+y2jiEDy
         eYeycxjXLru7k3CihqtOZP67mQb3AJIVsbZ/RR/rEHWwY7T2Qa7bLIDRGs020w1HHX+G
         9jjS47Ied1ZloHMm2TUcIh6GoBWXyOnBzPu1oBQhx7XrhhIvVvVFc6bsESoMJdRfL+kh
         gFBn7czwl5gB+UcDfEOwU9SPRsPhCQEYRpdHg0sTEa+TFzmCp33EqTJFAColJUqPz7Ru
         HNNv6DKW5rDqjprJ1zcoKC00CozbG3RNOywRd6A9UENHYFGGiEvI6mKzxtZZTzLBAL/p
         8xIQ==
X-Gm-Message-State: AOAM530UUEvB/8KttNP9crl7fJnZLFpEUDNSJalJDBFzMeKFrI2SF2HS
        5FCj83BZJz8NZWLus1DuSUyduw==
X-Google-Smtp-Source: ABdhPJy3Vtfk3XyAkY9PZHloMzZiAILa1njNOCS+o8g5KjjLlnecQ0zriR9i8lPY2GbFfvPaA8NoDw==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr18021616wru.374.1601900297402;
        Mon, 05 Oct 2020 05:18:17 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id u15sm12143712wml.21.2020.10.05.05.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:18:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:18:13 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/16] devlink: Add devlink reload limit option
Message-ID: <20201005121813.GA6617@nanopsycho>
References: <1601560759-11030-1-git-send-email-moshe@mellanox.com>
 <1601560759-11030-4-git-send-email-moshe@mellanox.com>
 <20201003075100.GC3159@nanopsycho.orion>
 <f91809cf-268d-64de-8a19-12305a3c11e0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91809cf-268d-64de-8a19-12305a3c11e0@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Oct 04, 2020 at 08:42:47AM CEST, moshe@nvidia.com wrote:
>
>On 10/3/2020 10:51 AM, Jiri Pirko wrote:
>> Thu, Oct 01, 2020 at 03:59:06PM CEST, moshe@mellanox.com wrote:
>> 
>> [...]
>> 
>> > enum devlink_attr {
>> > 	/* don't change the order or add anything between, this is ABI! */
>> > 	DEVLINK_ATTR_UNSPEC,
>> > @@ -507,6 +524,7 @@ enum devlink_attr {
>> > 
>> > 	DEVLINK_ATTR_RELOAD_ACTION,		/* u8 */
>> > 	DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED,	/* u64 */
>> > +	DEVLINK_ATTR_RELOAD_LIMIT,	/* u8 */
>> Hmm, why there could be specified only single "limit"? I believe this
>> should be a bitfield. Same for the internal api to the driver.
>
>
>Why bitfield ? Either the user asks for a specific limit or he doesn't ask
>for any (unspecified).

He can ask for multiple limits: No_link_flag , no_something_else. Could
be totally unrelated limitations. Let's just have the UAPI ready for
this once we define it from scratch.


>
>If the user doesn't need limitation he will not specify a limit.
>
>> [...]
