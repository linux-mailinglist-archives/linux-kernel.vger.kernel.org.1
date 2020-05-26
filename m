Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1B1A73C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406065AbgDNGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDNGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:37:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F917C0A3BDC;
        Mon, 13 Apr 2020 23:37:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b11so1574986wrs.6;
        Mon, 13 Apr 2020 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFX/jsoWIcT02fNetPwaD9iwvPSCwEXahfTDeUhkQ7I=;
        b=ZgBfwm0FWGuEqUBfv+SgRPDKruwdcC4UAX2OvYMw+YPuI8leNy+tdZHH9u81EyLY4I
         v94PPqCbqctKXpzj7HMwjS+3bD4EpqUi2IcQ1vRcHXBQnXOQ0KxNmx35g4SDnpPXsS60
         MB8DmAsXOAMJzSFaeYFTQzKcGwP2dh9DXyDrppy9XZ08q0NRHbbutijIxG+FUEMgAzCz
         UF6ckTYLhSkWF436Yv7GsaOMFe3Y66q95CbBru0v6+Jrbc9NTOJIWNK81nKzxI/9l+gr
         Eo7jAVXsFjg4tjHOkQA3XMpUlq0wCMVkJKl4VqYeOKny8yPzS/AP9PgqRSeAz3/uqYE7
         JGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFX/jsoWIcT02fNetPwaD9iwvPSCwEXahfTDeUhkQ7I=;
        b=QwouQ8GBBI2xATkpukGI83dcgF/AhCW+TaJsAL2vM81cJuykVhfj8f82ZopHyTADp9
         Ncp/AlkKOmdn4sTkbJhBDwOErnxliOZCE6pXXZuCuNne41is7X5dubVWPYaghhDQ+cUY
         Vlwgf07PV4m37qvxqMQY0Xww6iwSdahCMalZUOs+piZ5dwTkMYh9zBrsiurAmqQGLKEw
         ZTOuf2VQFWiWI7ec38n0PIG8CoeMhkzAoh+ZdrajTZeLLe/7dMuOhMq32MG8tFyrCisM
         fi2xmB4HW/YqrtbuFV1O1wKC+Dmoj7jFLyPlLw+Jz2HrMjpQN6miWSPAaT8YxEjpKmeE
         h5/A==
X-Gm-Message-State: AGi0PuYNR8QXDb5Ro+NyLOshkMuuTcnen064JMfBo2hzhv0PI+eDVPVn
        WYOTAFaz0GvU3xtRusA6u8RUVgPQ
X-Google-Smtp-Source: APiQypLb62A/HzHxn0dhVx4JjYWSJTZx3pr/X9Em1WIxyO8cO4BiIMgRFDunQcUHOz5DDa9RCX01JA==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr22689506wrb.54.1586846261966;
        Mon, 13 Apr 2020 23:37:41 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y10sm13336438wma.5.2020.04.13.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 23:37:41 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:37:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, joel@joelfernandes.org
Subject: Re: [GIT PULL rcu/urgent] Don't acquire lock in NMI handler (v5.7)
Message-ID: <20200414063739.GE84326@gmail.com>
References: <20200406011036.GA1435@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406011036.GA1435@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello!
> 
> This pull request contains a single commit that avoid acquiring
> a lock when rcu_nmi_enter_common() is invoked from an NMI handler.
> This issue can of course result in self-deadlock, and the fix is quite
> straightforward.  I am therefore putting it forward for the current
> release (v5.7) instead of following my normal process, which would
> delay it until v5.8.
> 
> This fix has been subjected to rcutorture, kbuild test robot, and -next
> testing and is available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo
> 
> for you to fetch changes up to bf37da98c51825c90432d340e135cced37a7460d:
> 
>   rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common() (2020-04-05 14:22:15 -0700)
> 
> ----------------------------------------------------------------
> Paul E. McKenney (1):
>       rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common()
> 
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pulled into tip:core/urgent, thanks Paul!

	Ingo
