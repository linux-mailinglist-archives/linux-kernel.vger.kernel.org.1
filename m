Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768D82F563E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhANBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbhANBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:11:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7276323436;
        Thu, 14 Jan 2021 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610586654;
        bh=UmdDGjhuO3WSPUKkGpPebqTr54sAnPseGUTkQpK7tfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V46Fwy0Q3g4zQPpDbmb+5EsbOAop1lfCRvhzNL2TAP1jLQYQENBoI6fJn5/8redMx
         O+T8GJgwC6mKlmWNxHD7tuGMRTPjdZSfEOAQEwsKeupk67Z0xNHYAhoQfEmcKHV8Ha
         hzik5RJVhjiBeg8GKb9i10DwdbS7mNIyrHkur68KPs/phgQN+b0xOpNgIEuvUHl/o5
         ZcgjbWl2gZevuRd1bDU5qbYwWMn0MQgeBS89fmd41NAmWl/BU05glASCkUaLaSL+Ml
         RmCb0X1QXDFlIqtprfgSVA+knbjKzLpwK2Ekn5nh920aiZ0PPoVb9WgEU5PglFyvgv
         o9Y59pplHpkQw==
Received: by mail-ed1-f50.google.com with SMTP id g24so3970422edw.9;
        Wed, 13 Jan 2021 17:10:54 -0800 (PST)
X-Gm-Message-State: AOAM530Dee/xakfMF93+BQAL88tTYHXay4E8pDdkAoAACWZqmq4WNx2u
        bULgmT3jFtosfewep+yOhpEVlr7b4tux1cJd+w==
X-Google-Smtp-Source: ABdhPJy61qEn7d8wXX2zq28pD76sJxB/TuBfKUuZufmasFatDoK02ubAgDBK8O4XP/Iyfo7DfgTG2FviLKULPwayyWc=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr3891482edd.62.1610586652810;
 Wed, 13 Jan 2021 17:10:52 -0800 (PST)
MIME-Version: 1.0
References: <87pn29pc5w.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pn29pc5w.wl-kuninori.morimoto.gx@renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Jan 2021 19:10:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEDd57L9edqtHQGf92oJZ02w-C8kZ064ijdcWbohwOhA@mail.gmail.com>
Message-ID: <CAL_JsqLEDd57L9edqtHQGf92oJZ02w-C8kZ064ijdcWbohwOhA@mail.gmail.com>
Subject: Re: [PATCH] of: property: add port base loop
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:53 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> We have endpoint base functions
>         - of_graph_get_next_endpoint()
>         - of_graph_get_endpoint_count()
>         - for_each_endpoint_of_node()

I actually think these functions don't make sense. Iterating over
endpoints for a port make sense, but not all endpoints.

> Here, for_each_endpoint_of_node() loop finds endpoint
>
>         ports {
>                 port@0 {
> (1)                     endpoint {...};
>                 };
>                 port@1 {
> (2)                     endpoint {...};
>                 };
>                 ...
>         };
>
> In above case, for_each_endpoint_of_node() loop
> finds endpoint as (1) -> (2) -> ...
> We can check endpoint parent to get its port
> if user want to do something to it.
>
> But port can have multi endpoints.
> In such case, it is difficult to find
> port@0 -> port@1 -> ...
>
>         ports {
>                 port@0 {
> (1)                     endpoint@0 {...};
> (2)                     endpoint@1 {...};
>                 };
>                 port@1 {
> (3)                     endpoint {...};
>                 };
>                 ...
>         };
>
> In such case, people want to have port base loop
> instead of endpoints base loop.
> This patch adds such functions/macros.

I'm a bit hesitant on these too. A driver should generally know what
each port # is (since the binding has to define them), and it should
just request the port (or its connection) it wants. At least that was
the premise behind of_graph_get_remote_node() and the cleanups (mostly
DRM drivers) I did to use it. I'd rather see things move in that
direction.

In any case, this needs a user before merging.

>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/of/property.c    | 69 ++++++++++++++++++++++++++++++++++------
>  include/linux/of_graph.h | 14 ++++++++
>  2 files changed, 73 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 5f9eed79a8aa..9b511cfe97b3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -631,15 +631,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>          * parent port node.
>          */
>         if (!prev) {
> -               struct device_node *node;
> -
> -               node = of_get_child_by_name(parent, "ports");
> -               if (node)
> -                       parent = node;
> -
> -               port = of_get_child_by_name(parent, "port");
> -               of_node_put(node);
> -
> +               port = of_graph_get_next_port(parent, NULL);
>                 if (!port) {
>                         pr_err("graph: no port node found in %pOF\n", parent);
>                         return NULL;
> @@ -666,14 +658,59 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>                 /* No more endpoints under this port, try the next one. */
>                 prev = NULL;
>
> +               port = of_graph_get_next_port(parent, port);
> +               if (!port)
> +                       return NULL;
> +       }
> +}
> +EXPORT_SYMBOL(of_graph_get_next_endpoint);
> +
> +/**
> + * of_graph_get_next_port() - get next port node
> + * @parent: pointer to the parent device node
> + * @prev: previous port node, or NULL to get first
> + *
> + * Return: An 'port' node pointer with refcount incremented. Refcount
> + * of the passed @prev node is decremented.
> + */
> +struct device_node *of_graph_get_next_port(const struct device_node *parent,
> +                                          struct device_node *prev)
> +{
> +       struct device_node *port = prev;
> +
> +       if (!parent)
> +               return NULL;
> +
> +       /*
> +        * Start by locating the port node. If no previous endpoint is specified
> +        * search for the first port node, otherwise get the previous endpoint
> +        * parent port node.
> +        */
> +       if (!port) {
> +               struct device_node *node;
> +
> +               node = of_get_child_by_name(parent, "ports");
> +               if (node)
> +                       parent = node;
> +
> +               port = of_get_child_by_name(parent, "port");
> +               of_node_put(node);
> +
> +               if (!port) {
> +                       pr_err("graph: no port node found in %pOF\n", parent);
> +                       return NULL;
> +               }
> +       } else {
>                 do {
>                         port = of_get_next_child(parent, port);
>                         if (!port)
>                                 return NULL;
>                 } while (!of_node_name_eq(port, "port"));
>         }
> +
> +       return port;
>  }
> -EXPORT_SYMBOL(of_graph_get_next_endpoint);
> +EXPORT_SYMBOL(of_graph_get_next_port);
>
>  /**
>   * of_graph_get_endpoint_by_regs() - get endpoint node of specific identifiers
> @@ -800,6 +837,18 @@ int of_graph_get_endpoint_count(const struct device_node *np)
>  }
>  EXPORT_SYMBOL(of_graph_get_endpoint_count);
>
> +int of_graph_get_port_count(const struct device_node *np)
> +{
> +       struct device_node *port;
> +       int num = 0;
> +
> +       for_each_port_of_node(np, port)
> +               num++;
> +
> +       return num;
> +}
> +EXPORT_SYMBOL(of_graph_get_port_count);
> +
>  /**
>   * of_graph_get_remote_node() - get remote parent device_node for given port/endpoint
>   * @node: pointer to parent device_node containing graph port/endpoint
> diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
> index 4d7756087b6b..8cd3bd674ebd 100644
> --- a/include/linux/of_graph.h
> +++ b/include/linux/of_graph.h
> @@ -26,6 +26,17 @@ struct of_endpoint {
>         const struct device_node *local_node;
>  };
>
> +/**
> + * for_each_port_of_node - iterate over every port in a device node
> + * @parent: parent device node containing ports and port
> + * @child: loop variable pointing to the current port node
> + *
> + * When breaking out of the loop, of_node_put(child) has to be called manually.
> + */
> +#define for_each_port_of_node(parent, child)                   \
> +       for (child = of_graph_get_next_port(parent, NULL); child != NULL; \
> +            child = of_graph_get_next_port(parent, child))
> +
>  /**
>   * for_each_endpoint_of_node - iterate over every endpoint in a device node
>   * @parent: parent device node containing ports and endpoints
> @@ -41,8 +52,11 @@ struct of_endpoint {
>  bool of_graph_is_present(const struct device_node *node);
>  int of_graph_parse_endpoint(const struct device_node *node,
>                                 struct of_endpoint *endpoint);
> +int of_graph_get_port_count(const struct device_node *np);
>  int of_graph_get_endpoint_count(const struct device_node *np);
>  struct device_node *of_graph_get_port_by_id(struct device_node *node, u32 id);
> +struct device_node *of_graph_get_next_port(const struct device_node *parent,
> +                                          struct device_node *previous);
>  struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>                                         struct device_node *previous);
>  struct device_node *of_graph_get_endpoint_by_regs(
> --
> 2.25.1
>
