Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122A1283C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgJEQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgJEQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:31:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77144C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:31:51 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j22so10114914qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YBVw09oCD2WGIwrQATE7+fQP8uN7Ej6Ms0bkSMhEu90=;
        b=ns/f2ttQDpYE+x0rJ7E42OFuduOs4LgV0T18HpW+yNuCxzTRKYLMgEQYF6ylYON0aV
         Gy9IAK5ox5H9TAXaH+Icomr6NmekeAM42wShB3tQZXcBSElb8zIm8bDwtZtc3286/3JV
         4h28Domig3IOAVTm8zfeLvUZNq1AFpLsiXh9aaxBD6+Z3jWUUEcT/1uHCkuHpKiIt/Ig
         LSJq2LtzHOGKa+CVdpzF5iMQDhdV4Ke1WvGtudr92QlcO29ekyE5aJFIXZL7t4kKftpK
         SCj9xCnrPkT54aYQoTvL3ClfGPJhSSV1z6bM9MmG7QWMhTJJLlNlgM4Bnhpj/bvHt0rp
         vRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YBVw09oCD2WGIwrQATE7+fQP8uN7Ej6Ms0bkSMhEu90=;
        b=S03tQLFZVZhX95cfbL3fTcF4055ZS1SMYJivjyqs2Lw81RHImsi/HQhTOCFaxtZMuB
         Dz2ujO6uj52eGKtzGTVvHb+jO2Ol1OR8smfySF3ZtO8aioNbK9+a0wVdx7iYrfcpBuLo
         +h9RV42IMWQmUcRdBsz6CVAFcEEUsX6jlrdkrP/cfH0X99inrAcxnQNYYz2ZdNxacU4+
         yyWgFINuXvCmHx75KPQgCSlPyhoR0DA2+uT55e4EQ2HFK7rxK6Bm25i8x68sDDFtDzOK
         5wGYtATiPWflX37Y9aY4U/MaZYcVc++V6ZehyjYhjAmD8UWC7DVPM6X7cd7BFlN+Wow7
         lw0A==
X-Gm-Message-State: AOAM531Jc+yxjaPMj9kaxerlSnc/VvhXkA48bZfJHZ3BYg8Vs9ba+OrE
        DWRmsHrW5D5r3pYvkWVxgA8=
X-Google-Smtp-Source: ABdhPJxLBptxwSzIaYMiAj/+sNjvh5iYQmQMopFDiMSXe10Fndms4ttZjvTB/1TXgnLh5VJRlycDAw==
X-Received: by 2002:ac8:5743:: with SMTP id 3mr648789qtx.259.1601915510479;
        Mon, 05 Oct 2020 09:31:50 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id m18sm383949qkg.77.2020.10.05.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:31:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Oct 2020 12:31:48 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH -v2 05/17] workqueue: Manually break affinity on hotplug
Message-ID: <20201005163148.GA3601@mtj.duckdns.org>
References: <20201005145717.346020688@infradead.org>
 <20201005150921.463998937@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150921.463998937@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:57:22PM +0200, Peter Zijlstra wrote:
> Don't rely on the scheduler to force break affinity for us -- it will
> stop doing that for per-cpu-kthreads.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
