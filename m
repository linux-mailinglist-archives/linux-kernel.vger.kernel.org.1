Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC761FFD47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgFRVRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgFRVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:17:19 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44623C06174E;
        Thu, 18 Jun 2020 14:17:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so4335528lfi.7;
        Thu, 18 Jun 2020 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=idHNUUuLhsbI+SMCrjb0o6RR15DaxhR7dGxO0G4VxCE=;
        b=HpuoGa6PnVdwnMuQ0O9frLNQHsBh6qEG75dT18PtTOeq3ScT6WdfmBEo1z/SV92bSd
         8RdFO8FoHlTigsz0Yp4gmOnz8lcrbT9OORjSvH/RvuhZM4ph/vq7bBh0DAedAqnciYau
         pwy6rep+9+nkMPVZjwGUXYoGYZVFdmHSe0Oc24G/QqtzLZ8r8lrRDshEeOMylbL9TqWo
         /f6J+8SCnCim4bDcofhpbH7g0IpXAbFV1xfM+b9eiZfwYNm0yxkwIBBnD2lTsM1TfU0y
         LHGRlHopuR/eT8JsqeDywlAAgMAS1K0IBBRnLV25uZ0C6xWFX0DdlqygvzdKW0+3d5pd
         +/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=idHNUUuLhsbI+SMCrjb0o6RR15DaxhR7dGxO0G4VxCE=;
        b=X6vxRh5aoDqYTWpVlLDRavoQ/hA1s9XKFJtlN+wmnYjZS3kdf6CzQYYkSrM+QXv+xf
         yqQBk4KPl1GwDz/gBfYlRtvF4neCupKHcenNNd7B7GnQOSu9LeKR8uiWe0bEU0S7m3uS
         Az9AAxHdHud4W1c7y2hgNhd+lPJ0Shl4VuGpIhVW2gqY1k0eUZstYiQXqZnL25OzEB5l
         oEVMynpNU4W5P0uUlxsUrygCrZ0ckquQ9G435oF3p8jJ328l2HVe0TVfW9eSaEsPsO9e
         pVgiBenyqaq4PMkLw3T7NLnIJrRqt9HNIzgsSHY+cBCmc47NYEb3xJJpgyZYQAfqnBSz
         6Uig==
X-Gm-Message-State: AOAM530mk/8jtPWmGG8l2grjN6GHAZmd/pD4ccrf2o+PWFcfrtTO9zsC
        yFkITYxa+5Iz3zhOeE1sEMA=
X-Google-Smtp-Source: ABdhPJza2WIVv0zoTR1seTP50OUqAb8gjUglXvAVMFnr1hlxbG9/1kxwveGGPE/EO0OfoFcG3M5O1g==
X-Received: by 2002:a05:6512:3295:: with SMTP id p21mr124276lfe.114.1592515035643;
        Thu, 18 Jun 2020 14:17:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 24sm985812lfy.59.2020.06.18.14.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:17:11 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 23:17:09 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618211709.GA17263@pc636>
References: <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618203821.GU8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > <snip>
> >     trace_rcu_invoke_kfree_bulk_callback(
> >         rcu_state.name, bkvhead[i]->nr_records,
> >             bkvhead[i]->records);
> >     if (i == 0)
> >         kfree_bulk(bkvhead[i]->nr_records,
> >             bkvhead[i]->records);
> >     else
> >         vfree_bulk(bkvhead[i]->nr_records,
> >             bkvhead[i]->records);
> > <snip>
> > 
> > Matthew, what is your thought?
> 
> That was my thinking too.  If we had a kvfree_bulk(), I would expect it to
> handle a mixture of vfree and kfree, but you've segregated them already.
> So I think this is better.
>
Yes, the segregation is done. Having vfree_bulk() is enough then.
We are on the same page :)

Thanks!

--
Vlad Rezki
