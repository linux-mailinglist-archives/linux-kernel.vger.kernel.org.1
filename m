Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7C27966B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIZDgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 23:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZDgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 23:36:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:36:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u25so4260805otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dyiwYFWGmDujhI5GwhY+kCTzE/oqCxO3zN0ObNzju24=;
        b=KU3kek6bssktGJqESLUk7dWYnY2hrP5Bj4aBKShvkGg0VmjV+BZvEpeECS4iScnoT/
         tXIzgDi7Hmjsh5n8zgzuMK40brSTC/I5TI/Rw4t+qO8bMv6gXEd9Usnc+i49Pt1vKz1/
         MrDugj06KhyE4CDlbkrQWt5Qy6jPA370ehHQpgRr+5km8JtslHkNAD6J6px7bDdKBZmW
         dgdzKZwegxtduOeeHeu7B+cfFpk0NyLHozl1fceG5dS+EinNe35SYbBiNeTdbf0HqiJx
         5XyFQjcBxBAJSeSdinR+dgSAB5DhkSw11bi+NWrBGFNkOg66qEB1UP53ak3ueqBUgMqs
         HSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyiwYFWGmDujhI5GwhY+kCTzE/oqCxO3zN0ObNzju24=;
        b=ewoqkw7NI+CylDiHSCd9wbIOOtLOIarW5GjCEfS5Dvl/8xicNwbFmoI4MS3+Mu75Q0
         PqPtW0y3TtaP5igPf/pgwhQfmhUOAZOEY152ylATOHTGRJOHU3lNbL6vy0kmCGJZQkdX
         WoYRYjprcWWz+VJscVEKG+D3hafjk4CRQSrxd0FOu+5rQZdcFq6fWPIXLczR+o9ibzTJ
         +0GfeYLjYVyFvvNAqKt3BRb4zW2VNi/P9FeH6f2Wlta3ZIU43hapnbGojMfLQr8FXmK1
         OUlofo1tXubZXF+y3EVtkmXwtGImkc66TZBoUGQdTQyO0Fal3h/VYhRst9O3QQ9gmLyf
         VX7A==
X-Gm-Message-State: AOAM531BZC+dYsh4r1Z8DY6nxGd2F4Oc6lesp0pXcmd5scvHQ9WtR1rE
        xhip5k9vXhbWwT8xMm4wf9cKbQ==
X-Google-Smtp-Source: ABdhPJxYkJC896CZZeUCE/Rk5suCyN+1W/Q2lhCFbJapSfBIvlU8SiMsZlosT7AufHamFCcd+pXpMg==
X-Received: by 2002:a9d:241:: with SMTP id 59mr2482555otb.151.1601091394974;
        Fri, 25 Sep 2020 20:36:34 -0700 (PDT)
Received: from builder.lan (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id z20sm333999oor.3.2020.09.25.20.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 20:36:34 -0700 (PDT)
Date:   Fri, 25 Sep 2020 20:32:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v5 1/2] remoteproc: Move coredump configuration to sysfs
Message-ID: <20200926033201.GB10036@builder.lan>
References: <1600449731-3056-1-git-send-email-rishabhb@codeaurora.org>
 <1600449731-3056-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600449731-3056-2-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Sep 10:22 PDT 2020, Rishabh Bhatnagar wrote:
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
[..]
> +static ssize_t coredump_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_err(&rproc->dev, "can't change coredump configuration\n");
> +		return -EBUSY;
> +	}
> +
> +	if (sysfs_streq(buf, "disable")) {

As pointed out by Sibi (somewhere) this should be "disabled" to match
what's returned in coredump_show() and what goes into the recovery
file.

> +		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
> +	} else if (sysfs_streq(buf, "inline")) {
> +		rproc->dump_conf = RPROC_COREDUMP_INLINE;
> +	} else if (sysfs_streq(buf, "default")) {

As I pointed out in a previous review, I think it makes sense to change
the default for dump_conf to "disabled" (a separate change). But in
doing so using the word "default" in the sysfs interface would be
misleading - and once it's part of sysfs it stays.

So how about changing this to "enabled"?

PS. The change of the default value of dump_conf would, in line with
Mathieu's ask, be a separate/unrelated change.

Regards,
Bjorn
