Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3669A2FBFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbhASTEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392097AbhASRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:55:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C29C0612AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:50:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so13343472wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QyIodkkZpgmT2iR30lRiS5kXCqh8xngPTa6Q/4z6lo=;
        b=Qt4vvqQwyNDmj1bMkqPUojF1T9yjuifa6xKH6ZVj9WU0u5V7h88xINffkPLD6eWFWd
         6n6fjXK0XkPDyarwiK7xVFtTmgKc83YLNx5r6Iq//VJe3vst6/cn7wK9WsSHtNoZ3REJ
         uluB68Cz1NwVCjVhuVrW+rg6bpItXeZvbkMPT8uoXY8BfbU0PjsD17Jjp6/NEd/IckZs
         7/7vlPRj/H/UAlUBTXh8H2g31h6Ekn9Lj3Bd+ISx3bGcOuX6oyJqfm5WruawkQZMXA5u
         O4x2dNbr5zAibMsIv22wrwmmTVPxvFvfAQhht3gOtbV9RYh78LlquoDzErOXoPw9Tngz
         fizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QyIodkkZpgmT2iR30lRiS5kXCqh8xngPTa6Q/4z6lo=;
        b=jz2GAOZRO3h3W2yjBJJWZHUj9g60D5iSbjSi5Ghsh4VJnYqK2t9LJ4bp534gOCBtN4
         OHnMZ51L40Uz+4EksGv0+jaZ+lo5JDIwvzzjzGhaYsa7ycaIwApELTenfLjxg0yu9je/
         UH3RHJcu2+I3lvxdCX5hJPynWr8daPwuh22U9/NkfQCjRqPE80A7WE4jS867rCAIlBSX
         6I1U1X+0OePYnFzTSEBOlAZjITCcY48/XKAdkaGL8vg+DHUB4ZD7xwFtuDxEiPZP4TE2
         O9/IH8Knm+3kyvno/j43Q+BuDUFAH+u59v+NjhhudKyt5Okm4MtW9E+LurPLqb3t3ABx
         YrKA==
X-Gm-Message-State: AOAM530GcV5fMh2SboTS+lj60094AltO0zGsRLjeS59dcScWAkeO2coK
        y+2bRjm1z6JMfBe0f9cvOLIwyw==
X-Google-Smtp-Source: ABdhPJzGnUo98SATM0bTGQ1kdvWBwjln5Z1FIJ7MlFjkOpQBZ/vX3cjfYeIa4p+F4/A3ybKR1o+A6w==
X-Received: by 2002:a5d:58d7:: with SMTP id o23mr5580520wrf.288.1611078625553;
        Tue, 19 Jan 2021 09:50:25 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id l20sm40342910wrh.82.2021.01.19.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:50:24 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:50:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is
 pinned
Message-ID: <YAcb3vUFovqz1gCL@google.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
 <YAb8XGyp3NtrHl+U@google.com>
 <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
 <YAcO9HHHVBx7oBG/@google.com>
 <20210119174244.3p2graxd5gonv4di@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174244.3p2graxd5gonv4di@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jan 2021 at 17:42:44 (+0000), Qais Yousef wrote:
> Hmm IIUC you want to still tag it as misfit so it'll be balanced within the
> little cores in case there's another core with more spare capacity, right?

Well yes but that's just a special case. But even you have big CPUs in
the affinity mask, you may find that the task fits on none of the CPUs
because they're currently under pressure. But in this case, you may
still want to mark the task as misfit because being under pressure may
be a relatively transient state.
