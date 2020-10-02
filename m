Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDAB2817A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgJBQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:18:36 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:54358 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbgJBQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:18:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601655511; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=whNc0k6iZS9jVhUtXaRh3qR5AHdDHKShvRvwUbV8CQI=;
 b=wQem5jmEEYwIIAJywwM//EGjbxPw+QcG4KREsv6tDpOdMY0JU3/DkUrs5uOQp8KBo1ygXRos
 +aw9d55TG8eLg4n7/R6dFc23+PcpY0nqfLpHALZAPTXXnj1ec/CX2RsJaQ+eR6kNZ8tcN9Vx
 CmDf9YYN/IE1r+FcZHS7rFef4u4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f7752c4bfed2afaa6ff3b7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 16:18:12
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 000BFC433FF; Fri,  2 Oct 2020 16:18:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72C0FC433CA;
        Fri,  2 Oct 2020 16:18:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Oct 2020 21:48:11 +0530
From:   pintu@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
In-Reply-To: <20201002121137.GY20115@casper.infradead.org>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
 <20201002121137.GY20115@casper.infradead.org>
Message-ID: <783f85abc401aa9dbe7623819f9683fb@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-02 17:41, Matthew Wilcox wrote:

> 
> I don't think the __func__ is particularly useful information.  I would
> also expect the name of the process to be more interesting than the 
> PID.
> And why is the ppid useful?
> 

Dear Matthew, First, thank you so much for your review and comments.
I totally agree with you.
Yes, initially I included process-name but later removed it to shrink 
some lines.
I thought just pid should be enough to figure out the culprit process 
from dumps.
Okay, I agree __func__ can also be removed.
ppid, I thought might be useful, so I included it. Okay I will remove 
that too.

> Wouldn't this message be more useful?
> 
> fork: Would overcommit system (pid:162 name:./consume-and-fork.out)
> 

Okay, yes I think this should be sufficient.
But I think printing pages also should be good to indicate the users to 
lack
information about this commitment.

> ie put it in dup_mmap() and use current->comm

Sorry, this part about dup_mmap(), I could not understand.


Thanks,
Pintu
