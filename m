Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB632AA21B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgKGBzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 20:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgKGBzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 20:55:48 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 17:55:47 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id i193so2799150yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BodUzW5TzpyzsBiFy8KpmO7wElq7rUm1y3ABj5c0SYA=;
        b=EDhW5CjubF0Ktxu+JsZ4S9NNEvSLxwqD411cSGTGVMfp5xxigCXYNRd0j/miF1aUuh
         KaegTnMMaHF9qeQalGiGs8dEMpOOF7txYCayaRyC/nUcZ3FRKx5SSU8zahDlS8wo0NVj
         wtS1/n/zcyGoHlRlqylFyQVyKfL+9mGMHO5abk/UuU0vTvqKg84s7s1qD3bTcU7NnWfY
         TJC6KNfSxDGajHnKaT9ZNHH/ThuTUeEksMlv4mCrOcw78qvPPR8nYZ0CE7D9V9VETxg8
         Lg4DYj2nVdYq52uw9V34kz5B5LjgYR8jaeAKU1+P/4ht5iYHdKFLXqQMBLuquhBEAZdB
         IPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BodUzW5TzpyzsBiFy8KpmO7wElq7rUm1y3ABj5c0SYA=;
        b=YmRtRvn5/KveeGjfyoe6p++yYyLKeuzxyuJXk4fm6hISO+Nh/LDeZ7ConShH+e19a8
         9NTx3KKVRpnE8SCYobdUIprPPoSUjWKfr9GdAE5dTzak12Xxc/8yXEFKUr0YTyAB6Hlu
         r/p5sgM+9ywsY2aPp9SV+2O0nfex8mGFJPaxg+DL2BynGyEFiP2vS+yEKXeFLDLpRWkM
         9Y13CyVyBrat3laiEyLguZNMwb8/cijJwHcUAGsCn8ZsX62GwnoMLwtRud15YHgfMMz7
         3QXibat/VYIp7DPWXgV3fu/Tbv7RHWj7zomHBYk372ICXFvpWX3y5HTys7N2OaQLisrW
         165A==
X-Gm-Message-State: AOAM531Bp5aaXEV0vSGbrt8XxEtF0OOe8yVCSjOuigDC/llBajjRoi8F
        nmQ99HYsBK0JsBcBVQxirYy08P2vRJ5vlimEwAof+g==
X-Google-Smtp-Source: ABdhPJzcmDjZodIwyd9SBcD0pS/PLbAxzeGtQbzDHKAfI07XIDkn7ah83D0Whfs9G8PeAXxUg1sPzTqHl3xj4A4Uvlo=
X-Received: by 2002:a25:9c02:: with SMTP id c2mr6297800ybo.228.1604714146256;
 Fri, 06 Nov 2020 17:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20201106150747.31273-1-broonie@kernel.org> <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
 <20201106192300.GG49612@sirena.org.uk>
In-Reply-To: <20201106192300.GG49612@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Nov 2020 17:55:10 -0800
Message-ID: <CAGETcx_hoDS1jHxfvrQv_+oMQw6E=AAiPANED+Ob6+a9mohW_A@mail.gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 11:23 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 06, 2020 at 11:09:17AM -0800, Saravana Kannan wrote:
>
> > If you want to do this in "one common place", then I think the way to
> > do this is have include/linux/of.h provide something like:
>
> > void of_set_device_of_node(dev, of_node)
> > {
> >     dev->of_node = of_node;
> >     dev->fw_node = &of_node->fwnode;
> >    /* bunch of other housekeeping like setting OF_POPULATED and doing
> > proper of_node_get() */
> >    // Passing NULL for of_node could undo all the above for dev->of_node.
> > }
>
> That also sounds good, particularly if we have a coccinelle spatch

I've never used coccinelle. But I can fix 5-10 easily findable ones
like i2c, platform, spi, slimbus, spmi, etc.

> or
> some other mechanism that enforced the usage of the function where
> appropriate, my main concern is making sure that we do something which
> ensures that the boilerplate stuff is handled.

Rob/Frank,

I spent an hour or more looking at this and there are many ways of
doing this. Wanted to know how much you wanted to do inside these
boilerplate functions.

This is the minimum we should do in these helper functions.

+/**
+ * of_unset_dev_of_node - Unset a device's of_node
+ * @dev - device to unset the of_node for
+ *
+ * Use this when you delete a device on which you had called
+ * of_set_dev_of_node() before.
+ */
+static inline void of_unset_dev_of_node(struct device *dev)
+{
+       struct device_node *node = dev->of_node
+
+       if (!node)
+               return;
+
+       dev->fwnode = NULL;
+       dev->of_node = NULL;
+       of_node_put(node);
+}
+
+/**
+ * of_set_dev_of_node - Set a device's of_node
+ * @dev - device to set the of_node for
+ * @node - the device_node that the device was constructed from
+ *
+ * Use this when you create a new device from a device_node. It takes care some
+ * of the housekeeping work that's necessary when you set a device's of_node.
+ *
+ * Use of_unset_dev_of_node() before you delete the device.
+ *
+ * Returns an error if the device already has its of_node set.
+ */
+static inline int of_set_dev_of_node(struct device *dev, struct
device_node *node)
+{
+       if (!node)
+               return 0;
+
+       if (WARN_ON(dev->of_node))
+               return -EBUSY;
+
+       of_node_get(node);
+       dev->of_node = node;
+       dev->fwnode = of_fwnode_handle(node);
+
+       return 0;
+}

But I also had another version that set/cleared OF_POPULATED. But that
meant of_device_alloc() will allocate the device before checking if
the node has already been populated (because I'd delete the check
that's already there and use the one rolled into these helper
functions). I think that inefficiency is okay because I don't think
"trying to populate an already populated node" would be a common
occurrence. But I wasn't sure how you'd feel about it.

Any preferences? Thoughts?

Additional context:
https://lore.kernel.org/lkml/20201104205431.3795207-2-saravanak@google.com/

-Saravana
