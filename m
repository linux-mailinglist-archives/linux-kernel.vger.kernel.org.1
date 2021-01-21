Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9772FE086
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAUEWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbhAUESk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:18:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33DC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:18:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so571654plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4tTr8eXgVxiwRpPC9gZvJZDtddYvKVLD2bFKDwCFSiA=;
        b=PV6eVrZXQByxMSbKyDIAVtuZtlF5kM/z3qCYq7aLGz6D3nxRURPTor8Gp9IKD26iZa
         pxCNHdb7B3A0A/ukNsrBTfcWWqyQ/TZFMW8sOScCtCkhazrXnQpkUncInTnXnshGgyRJ
         85jbWWDrHTVX/4il9NSxKfcFoVkLD18N4B6t23fbobPsXqXvRZxcnS0SUK0QH9lReqnJ
         k10NQC1qoDp1GXUJOuYqV8efkhvti1UNOWvCZwQFhTLrkqqlbW2hk0NcwSJ3SVrbaLkj
         n26HYIs6iiymw7lh+M6s/2viOnSOCxSanQ9OvTRD7iweYM5cwZmHh/a4jN0b6VfOjxtv
         U0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4tTr8eXgVxiwRpPC9gZvJZDtddYvKVLD2bFKDwCFSiA=;
        b=j2xAXzN+Cq/iY4v8diseRJD2s+AqXiRMC+C7XfFZ+P4oTnDKe+MwhWUOZifkOX2X6W
         50IJWcRcZSoERAu67Gzs/PwsZZ+Px+/FVifu6a92VEL3WCErNg5iBqKyW4qeIiBen9I0
         BWkW2EI7jxoIav5yeIiGMlk5tyXTTWzZYF7/LF0qvzlFhNLZ19PW0CYETy38PGVgPgOR
         RgiVgnbKExe0OITrCFfUS7ddf7y7clIvMEwU26Q+nRvxrelHBCdUFjspr3L8IluqI6ST
         wXsGTK74nKCSMlry9LtMJZEuxkACmGzybfaR8Y3tL8XSY0r7LJWGDPwh3WHBuKZceGIZ
         kxpA==
X-Gm-Message-State: AOAM533yfZYD+Ao7dVIwwDFivV4jYRnS6212oSc4QMOKsiUTytEsrDWw
        aUCjGHRqizGuiB/WRq1scXzYWQ==
X-Google-Smtp-Source: ABdhPJw/jXkwi5A1wuQNM2yFxvpDQNZHFYeg9vIMkqXkkdaqAm7dJKntq6dLaTRAmbcGvPZslX5GDA==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr9182278pjb.41.1611202679751;
        Wed, 20 Jan 2021 20:17:59 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n7sm3816756pfn.141.2021.01.20.20.17.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:17:59 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:47:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 3/5] scripts: dtc: Remove the unused fdtdump.c file
Message-ID: <20210121041757.cskxlai5e7a2pfgb@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
 <20210121004457.GD5174@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121004457.GD5174@yekko.fritz.box>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-21, 11:44, David Gibson wrote:
> On Wed, Jan 20, 2021 at 12:36:45PM +0530, Viresh Kumar wrote:
> > This was copied from external DTC repository long back and isn't used
> > anymore. Over that the dtc tool can be used to generate the dts source
> > back from the dtb. Remove the unused fdtdump.c file.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Doesn't this make updating the kernel dtc from upstream needlessly
> more difficult?

Hmm, I am not sure I understand the concern well. The kernel keeps a
list of files[1] it needs to automatically copy (using a script) from
the upstream dtc repo and fdtdump.c was never part of that. Keeping it
there isn't going to make any difficulty I believe.

-- 
viresh

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/update-dtc-source.sh
