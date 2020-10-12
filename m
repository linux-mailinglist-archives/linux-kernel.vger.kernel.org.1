Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1328BB91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbgJLPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388977AbgJLPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:10:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A6C0613D0;
        Mon, 12 Oct 2020 08:10:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so19583307wrq.11;
        Mon, 12 Oct 2020 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mkuNs+7XxlEVvtkC9IIAwWFcSgj3h27AZFQnWZFm0XA=;
        b=lUD7+AsC3gIYyuLjGVkGz6YiVnzefUHoKy63QYSNowSifa9yEth6OS7GbALyfbMTnr
         LvGTXyj7YkXluF2uD9dqQnuvjVR8sebs6lreneRQ5UYklalKSg8hSwL7XtVYdSCITphA
         6VmeQ8r4y2fXb8UQaxh/FVLnvuhzoyWwEaHfgjCtgA6EeO7agVwqK2i9dtf7U4DPMEMJ
         LSkgWoHtBoO8sD9NxY3EpZKVM+gxKt5WvICVfVYmWCRk6YWntGNc7G57vVSObnOVCAIo
         IMtIdelwKZzw7FmbW3qiIxI/3aCDdjnWAjhC82l+zk0ZJvGPVPq6q7bjlp3AmYTk8rZM
         6KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mkuNs+7XxlEVvtkC9IIAwWFcSgj3h27AZFQnWZFm0XA=;
        b=o2vGmNCz1MUut4ppU+ejY3KLXSpoC4kZ0q8aT1BoW6FXki+baAlgUlI8UG7Y8eNind
         GFrF72FHv6DDu5FPtZJynDwSGc0I7MnzdBZaLJQUEtEir9AbKVknU3rWCk9W9hLvIV5K
         e78jOAOPXFgKmrsv5BcS1FjPsW6aig/D/5RI1yODTDVFgdXik+f2NYShMTK2HF884Yas
         fVohy0mqN/DJnrlQYCKzSnQkvCsD7aeXcciT9uJ+8MKftmKhGPdeqY/JhWzPJ00hKxVn
         I5FQl4sMNBPXyqtXJ/L2zl/PwljnAubc7lBl0uo0vGU+TB0TiFF26TzEK/bK9gUUSqcx
         eryA==
X-Gm-Message-State: AOAM531/QHT9uRorEPavkm3BXW/on2s3CwkZHTm84MlYWKbPPt71PSkt
        iEq9pROIoIyaJD4NOZ27svpMKjNCUfhgG1R3
X-Google-Smtp-Source: ABdhPJyFfLN8mAuNx/DYHdt0jVUfqeX8Dq1RkoyYSUAkOjaB1Na7Vv03X4kTC2bPoZCBiPZ8BFtgGA==
X-Received: by 2002:adf:f305:: with SMTP id i5mr25025707wro.346.1602515423074;
        Mon, 12 Oct 2020 08:10:23 -0700 (PDT)
Received: from felia ([2001:16b8:2d57:fc00:8472:203c:3ecb:c442])
        by smtp.gmail.com with ESMTPSA id c185sm2406624wma.44.2020.10.12.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:10:22 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 12 Oct 2020 17:10:21 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
In-Reply-To: <20201012145710.GA631710@rowland.harvard.edu>
Message-ID: <alpine.DEB.2.21.2010121659040.6487@felia>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Oct 2020, Alan Stern wrote:

> On Mon, Oct 12, 2020 at 04:11:38PM +0200, Lukas Bulwahn wrote:
> > 
> > 
> > On Sun, 11 Oct 2020, Sudip Mukherjee wrote:
> > 
> > > Add a comment explaining why find_tt() will not return error even though
> > > find_tt() is checking for NULL and other errors.
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > 
> > I get the intent of the comment but there is a large risk that somebody 
> > could remove the find_tt() call before the calling the function and there 
> > is no chance to then see later that the comment is actually wrong.
> 
> Why would anybody do that?  Who would deliberately go change a driver in 
> a way that is obviously wrong and would break it?  Especially when such 
> changes are likely to cause compile errors?
> 
> There are tons of changes one might make to any program that will leave 
> it syntactically valid but will cause it to fail.  What's special about 
> removing the early calls to find_tt()?
> 
> > I guess you want to link this comment here to a code line above and
> > request anyone touching the line above to reconsider the comment then.
> 
> That really seems unnecessary.
> 
> > But there is no 'concept' for such kind of requests to changes and 
> > comments.
> > 
> > So, the comment is true now, but might be true or wrong later.
> > 
> > I am wondering if such comment deserves to be included if we cannot check 
> > its validity later...
> > 
> > I would prefer a simple tool that could check that your basic assumption 
> > on the code is valid and if it the basic assumption is still valid, 
> > just shut up any stupid tool that simply does not get that these calls 
> > here cannot return any error.
> 
> Real code contains so many assumptions, especially if you include ones 
> which are obvious to everybody, that such a tool seems impractical.
>

I fear that problem applies to all static code analysis tools I have seen; 
at some point, the remaining findings are simply obviously wrong to 
everybody but the tool does not get those assumptions and continues 
complaining, making the tool seem impractical.

Alan, so would you be willing to take patches where _anyone_ simply adds 
comments on what functions returns, depending on what this person might 
consider just not obvious enough?

Or are you going to simply reject this 'added a comment' patch here?

I am not arguing either way, it is just that it is unclear to me what the 
added value of the comment really is here.

And for the static analysis finding, we need to find a way to ignore this 
finding without simply ignoring all findings or new findings that just 
look very similar to the original finding, but which are valid.

Lukas
