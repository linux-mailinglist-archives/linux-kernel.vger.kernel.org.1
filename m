Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF522D768F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436805AbgLKN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393599AbgLKN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:27:47 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDEC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:27:06 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id t16so2057556vkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pj/iTP2OUYJfo2oOEAqIyIwYl9JlGtTjF8TCkgXFByk=;
        b=DbUUj3/ikACiYSNE0yN0EJay2QcdyOY+LPohBtrPSnhzaus1fKRb/XBVVhp52mo48P
         iMaQFDZ9T2xvxJT8RedlUE53ScpPCOBuIE6XdLcn+2s0tyOlgl52NE2KSqPsbARw/URB
         zALOUDi4zA56jdKB5sG9V1W5+PRAJFvI3lT7mOaQ6/2NjxWfeYqvbwDxZuczPpW4lcsE
         McTT9hyCh7zs9/tdMXkZZvKCUmg6tlXW616adnfFqnVoe+9zQjX1a5tQj+QMO1pM4C69
         y9BFmf4DC8sRAZriwtjLjltxywsSSbspRt+oaJzTIz8spPbuDD9LfEDMRqEJlhQMpzLH
         2mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pj/iTP2OUYJfo2oOEAqIyIwYl9JlGtTjF8TCkgXFByk=;
        b=G4Rq8pynypjItQMPJIzjKlf3iGtPW30whv7XlSziSyTL7rcAVopdhKCgNJcBzTPK9s
         ZGMERbNZC357vTgIuLcUx9yFK4bwhr8OKJZbuFUoFs2FhkDVv2zymIseEvnA2P51Xfqc
         XeWSn9kf5AuxKWNitr/iisXeo+FvR2crdgEJ7J05BSWn2lh8oI8RQ+QSJ/8nuPPXUXhm
         xvFpLQGB5blAXDvs4aRrhJQ00eThw0UGvUwdeJHYzfDeWJrTZ4eM/tnTF2h1Olo6ddan
         bSmiRh5se6xlcJWOSuO1Ew2JM0zerMqa/NpoWSSaWGbNG8HlwLi0cgLIo8MNdpo1MFoq
         ECFA==
X-Gm-Message-State: AOAM532jMV0lnEYXD4JhY/elduFaBaf0ygSeC7YW7SapgIr+D/KtiaMg
        ALr0z+ENnt37kKz5MmewuAz+nrWdb33hd2/3iojitw==
X-Google-Smtp-Source: ABdhPJxLq5lvK8WQVNWQXgpktS6VQnJPaHvIn92OkeOMsGtUnP4FJM0r/ZrffRMARKBhjy3mLy+Cc0ff03VGEF0PhFE=
X-Received: by 2002:a1f:d286:: with SMTP id j128mr13606820vkg.8.1607693226138;
 Fri, 11 Dec 2020 05:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20201210202944.6747-1-semen.protsenko@linaro.org> <f18dea6e-5806-370c-0d83-e56f3dc118b4@gmail.com>
In-Reply-To: <f18dea6e-5806-370c-0d83-e56f3dc118b4@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 11 Dec 2020 15:26:54 +0200
Message-ID: <CAPLW+4nLi2236-EL0d=X9bzv11LiBJd2c5NY5aY4qZHL3rUCgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: Get rid of code duplication in port getting
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Dec 2020 at 22:59, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 10.12.2020 23:29, Sam Protsenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Both of_graph_is_present() and of_graph_get_next_endpoint() functions
> > share common piece of code for obtaining the graph port. Extract it int=
o
> > separate static function to get rid of code duplication and avoid
> > possible coding errors in future.
> >
> > Fixes: 4ec0a44ba8d7 ("of_graph: add of_graph_is_present()")
>
> The "fixes" tag should be used only for bug-fixes and there is no bug
> fixed in this patch.
>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/of/property.c | 34 ++++++++++++++++++++--------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 408a7b5f06a9..da111fcf37ac 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -30,13 +30,13 @@
> >  #include "of_private.h"
> >
> >  /**
> > - * of_graph_is_present() - check graph's presence
> > + * of_graph_get_port - find the "port" node in a given node
> >   * @node: pointer to device_node containing graph port
> >   *
> > - * Return: True if @node has a port or ports (with a port) sub-node,
> > - * false otherwise.
> > + * Return: A 'port' node pointer with refcount incremented if found or=
 NULL
> > + * otherwise. The caller has to use of_node_put() on it when done.
> >   */
> > -bool of_graph_is_present(const struct device_node *node)
> > +static struct device_node *of_graph_get_port(const struct device_node =
*node)
> >  {
> >       struct device_node *ports, *port;
> >
> > @@ -46,8 +46,22 @@ bool of_graph_is_present(const struct device_node *n=
ode)
> >
> >       port =3D of_get_child_by_name(node, "port");
> >       of_node_put(ports);
> > -     of_node_put(port);
> >
> > +     return port;
> > +}
> > +
> > +/**
> > + * of_graph_is_present() - check graph's presence
> > + * @node: pointer to device_node containing graph port
> > + *
> > + * Return: True if @node has a port or ports (with a port) sub-node,
> > + * false otherwise.
> > + */
> > +bool of_graph_is_present(const struct device_node *node)
> > +{
> > +     struct device_node *port =3D of_graph_get_port(node);
> > +
> > +     of_node_put(port);
> >       return !!port;
> >  }
> >  EXPORT_SYMBOL(of_graph_is_present);
> > @@ -631,15 +645,7 @@ struct device_node *of_graph_get_next_endpoint(con=
st struct device_node *parent,
> >        * parent port node.
> >        */
> >       if (!prev) {
> > -             struct device_node *node;
> > -
> > -             node =3D of_get_child_by_name(parent, "ports");
> > -             if (node)
> > -                     parent =3D node;
> > -
> > -             port =3D of_get_child_by_name(parent, "port");
> > -             of_node_put(node);
> > -
> > +             port =3D of_graph_get_port(parent);
> >               if (!port) {
> >                       pr_err("graph: no port node found in %pOF\n", par=
ent);
> >                       return NULL;
> >
>
> This repeats the problem which was made once before:
>

You are right. Inlining is probably the best solution here. Let's drop
this patch and keep everything as is. Thanks for catching this!

> https://lore.kernel.org/patchwork/patch/1266028/#1461493
