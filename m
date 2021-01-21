Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D62FF0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbhAUQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:47:32 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56965 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388069AbhAUQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:37:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 52C6258052E;
        Thu, 21 Jan 2021 11:36:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Jan 2021 11:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        YJdxl7AyCvWTYx/FjMErajpnwze1gn0rJs1EcbgXfwo=; b=hv9i9oYm8t2EEGgZ
        Rg8zBM6SfuJwrknmfLal3HvjlkNDzJbtm7PgwWqE2198r32F3Uyl19++yK1FiFnY
        YomFQuSeP1au66IAWwQEES+zU24v2Jt/Uj9jGs7gZ6GK6GyItrd/s6MtsuhDcPc6
        xmZj4k2c+cnBumfPQJQh/uZC1MjD1huwBcUdeibhAEVo5sXIcefHeMxaBgIqTcGg
        gsdURuGTOwSgzg8TD4YgXjhCX3ME99IkzpuS/P4WxmkENo2c/nd2w63QwzcU2RsR
        JHNk3My73hYQtAXZvq3BP1TdxvTEqNhASRWX2/934swz/2+2w2wHiok8esIduAmX
        xubo9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YJdxl7AyCvWTYx/FjMErajpnwze1gn0rJs1EcbgXf
        wo=; b=DhLfONsiVOMCw7tvUWhAloT5uPGlr+xPaLXsv2Xx6Go5lZ2nbP3giQxos
        MJ7HIVXzNjFSW24HcsULZb+zVHBIQoy4Ja3B6lJAAD4gSgNRybAEHV/d/S+cux+Z
        Fe1fWv9+NdMfkSYpR7qC2fRYDiljP1D2nh229q97sITzO18a/6WUAfI/ByXyBpkt
        GiL0OhWo/7u0RFcjQzQu9duILNz+kKE/FzmPkjsBpyFPqHYglNqbHdUjpO38vriY
        QaRouUSoKM65XHLSQ1SrYeKvEdc7WQr2KmSxbqfaP9BUJJiCVnwwHlmgr62Od99S
        gF/SUf/eZNvaANg6g/4E/e1wUJGdw==
X-ME-Sender: <xms:e60JYJtJYtqwjbnASxD2bS1RwRGUIMa6GjkVGeNroJ0HmjHA-x1t2A>
    <xme:e60JYCe11NYqtr2ANTZ6LATLzXPoZzKTR2gfsoLAWowo3J7V1wWIYJrugILTVE3Kx
    s7lfgxZDsNzV0aCifk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fK0JYMyDplySlZ42fVmhtxgLXXpIIIrVaAKOAmOHJlmBmpoGDpd2bg>
    <xmx:fK0JYAPSQrolEYgxHSXEHWaKJQJbBnwOSzUFCOsChpcXNDpx22a-IA>
    <xmx:fK0JYJ_hKci4D_MZMzoKKv8T1TsmE13kvtS__mWKEJMxPqtZUh5r6g>
    <xmx:fK0JYFT3bUOliadDPXQ_6xQ3tyKVRGJmfHNj-X1thrfSeWVb8IMXGQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCF9B1080057;
        Thu, 21 Jan 2021 11:36:11 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] drm/todo: Remove the drm_atomic_state todo item
Date:   Thu, 21 Jan 2021 17:35:36 +0100
Message-Id: <20210121163537.1466118-11-maxime@cerno.tech>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121163537.1466118-1-maxime@cerno.tech>
References: <20210121163537.1466118-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only planes' prepare_fb and cleanup_fb, and encoders' atomic_check and
atomic_mode_set hooks remain with an object state and not the global
drm_atomic_state.

prepare_fb and cleanup_fb operate by design on a given state and
depending on the calling site can operate on either the old or new
state, so it doesn't really make much sense to convert them.

The encoders' atomic_check and atomic_mode_set operate on the CRTC and
connector state connected to them since encoders don't have a state of
their own. Without those state pointers, we would need to get the CRTC
through the drm_connector_state crtc pointer.

However, in order to get the drm_connector_state pointer, we would need
to get the connector itself and while usually we have a single connector
connected to the encoder, we can't really get it from the encoder at
the moment since it could be behind any number of bridges.

While this could be addressed by (for example) listing all the
connectors and finding the one that has the encoder as its source, it
feels like an unnecessary rework for something that is slowly getting
replaced by bridges.

Since all the users that matter have been converted, let's remove the
TODO item.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v1:
  - New patch
---
 Documentation/gpu/todo.rst | 46 --------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 009d8e6c7e3c..609794108f5a 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -440,52 +440,6 @@ Contact: Emil Velikov, respective driver maintainers
 
 Level: Intermediate
 
-Plumb drm_atomic_state all over
--------------------------------
-
-Currently various atomic functions take just a single or a handful of
-object states (eg. plane state). While that single object state can
-suffice for some simple cases, we often have to dig out additional
-object states for dealing with various dependencies between the individual
-objects or the hardware they represent. The process of digging out the
-additional states is rather non-intuitive and error prone.
-
-To fix that most functions should rather take the overall
-drm_atomic_state as one of their parameters. The other parameters
-would generally be the object(s) we mainly want to interact with.
-
-For example, instead of
-
-.. code-block:: c
-
-   int (*atomic_check)(struct drm_plane *plane, struct drm_plane_state *state);
-
-we would have something like
-
-.. code-block:: c
-
-   int (*atomic_check)(struct drm_plane *plane, struct drm_atomic_state *state);
-
-The implementation can then trivially gain access to any required object
-state(s) via drm_atomic_get_plane_state(), drm_atomic_get_new_plane_state(),
-drm_atomic_get_old_plane_state(), and their equivalents for
-other object types.
-
-Additionally many drivers currently access the object->state pointer
-directly in their commit functions. That is not going to work if we
-eg. want to allow deeper commit pipelines as those pointers could
-then point to the states corresponding to a future commit instead of
-the current commit we're trying to process. Also non-blocking commits
-execute locklessly so there are serious concerns with dereferencing
-the object->state pointers without holding the locks that protect them.
-Use of drm_atomic_get_new_plane_state(), drm_atomic_get_old_plane_state(),
-etc. avoids these problems as well since they relate to a specific
-commit via the passed in drm_atomic_state.
-
-Contact: Ville Syrjälä, Daniel Vetter
-
-Level: Intermediate
-
 Use struct dma_buf_map throughout codebase
 ------------------------------------------
 
-- 
2.29.2

